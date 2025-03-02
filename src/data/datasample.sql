-- Create tables
CREATE TABLE users (
                       id VARCHAR(50) PRIMARY KEY,
                       name VARCHAR(255) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       profile_visibility BOOLEAN NOT NULL DEFAULT true,
                       role VARCHAR(50) NOT NULL DEFAULT 'user'
);

CREATE TABLE groups (
                        id VARCHAR(50) PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        description TEXT,
                        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        owner_id VARCHAR(50) NOT NULL REFERENCES users(id),
                        is_public BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE scripts (
                         id VARCHAR(50) PRIMARY KEY,
                         name VARCHAR(255) NOT NULL,
                         slug VARCHAR(255) UNIQUE NOT NULL,
                         content TEXT NOT NULL,
                         created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         author_id VARCHAR(50) NOT NULL REFERENCES users(id),
                         is_public BOOLEAN NOT NULL DEFAULT true,
                         likes_count INTEGER NOT NULL DEFAULT 0,
                         version VARCHAR(50) NOT NULL DEFAULT '1.0'
);

-- Many-to-many relationship tables
CREATE TABLE user_favorite_scripts (
                                       user_id VARCHAR(50) REFERENCES users(id) ON DELETE CASCADE,
                                       script_id VARCHAR(50) REFERENCES scripts(id) ON DELETE CASCADE,
                                       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                       PRIMARY KEY (user_id, script_id)
);

CREATE TABLE user_group_memberships (
                                        user_id VARCHAR(50) REFERENCES users(id) ON DELETE CASCADE,
                                        group_id VARCHAR(50) REFERENCES groups(id) ON DELETE CASCADE,
                                        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                        PRIMARY KEY (user_id, group_id)
);

CREATE TABLE group_scripts (
                               group_id VARCHAR(50) REFERENCES groups(id) ON DELETE CASCADE,
                               script_id VARCHAR(50) REFERENCES scripts(id) ON DELETE CASCADE,
                               created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (group_id, script_id)
);

CREATE TABLE user_script_likes (
                                   user_id VARCHAR(50) REFERENCES users(id) ON DELETE CASCADE,
                                   script_id VARCHAR(50) REFERENCES scripts(id) ON DELETE CASCADE,
                                   created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   PRIMARY KEY (user_id, script_id)
);

CREATE TABLE script_tags (
                             script_id VARCHAR(50) REFERENCES scripts(id) ON DELETE CASCADE,
                             tag VARCHAR(50) NOT NULL,
                             PRIMARY KEY (script_id, tag)
);

-- Insert sample data
-- Users
INSERT INTO users (id, name, email, password_hash, created_at, updated_at, profile_visibility, role)
VALUES
    ('u1', 'John Doe', 'john.doe@example.com', '$2a$10$dRFLSkYedQ1IaH1oxtmYzeIwj8JhGGdRwsRh.tFYoP8MK2igoXfK2', '2024-12-15 10:30:00', '2025-02-28 14:22:10', true, 'admin'),
    ('u2', 'Jane Smith', 'jane.smith@example.com', '$2a$10$M8JuVXf2iJrI7/z3y1n9S.A9c8vqTT4JlfBR5/LBgwrXcc5FPtLCy', '2024-12-20 08:45:22', '2025-01-15 16:10:05', true, 'user'),
    ('u3', 'Alice Johnson', 'alice.j@example.com', '$2a$10$X5jK9IrV2Q5Yt6xmYW5A7.HFK3qT7dS3rUUYnH5bqQKdgAVBq8JdC', '2025-01-05 11:20:15', '2025-01-05 11:20:15', false, 'user');

-- Groups
INSERT INTO groups (id, name, description, created_at, updated_at, owner_id, is_public)
VALUES
    ('g1', 'DevOps Team', 'Group for sharing DevOps automation scripts', '2024-12-12 09:00:00', '2025-02-10 15:30:00', 'u1', true),
    ('g2', 'Frontend Developers', 'JavaScript and UI utility scripts', '2024-12-18 14:25:00', '2025-01-20 10:15:00', 'u2', true),
    ('g3', 'Private Projects', 'Scripts for confidential company projects', '2025-01-10 16:40:00', '2025-02-25 11:55:00', 'u1', false);

-- Scripts
INSERT INTO scripts (id, name, slug, content, created_at, updated_at, author_id, is_public, likes_count, version)
VALUES
    ('s1', 'AWS S3 Bucket Cleanup', 'aws-s3-bucket-cleanup',
     E'#!/bin/bash\n# Script to clean up old files in S3 buckets\naws s3 ls s3://mybucket/ --recursive | grep ''2024-01'' | awk ''{print $4}'' | xargs -I {} aws s3 rm s3://mybucket/{}',
     '2024-12-14 11:20:00', '2025-02-15 09:10:00', 'u1', true, 5, '1.2'),

    ('s2', 'Docker Container Health Check', 'docker-container-health',
     E'#!/bin/bash\n# Script to check health of all running docker containers\ndocker ps --format ''{{.Names}}'' | xargs -I {} sh -c ''echo \"Container: {}\"; docker inspect --format=\"{{.State.Health.Status}}\" {}''',
     '2024-12-20 15:45:00', '2025-01-10 14:20:00', 'u1', true, 8, '1.0'),

    ('s3', 'CSS Minifier', 'css-minifier',
     E'const fs = require(''fs'');\nconst path = require(''path'');\nconst csso = require(''csso'');\n\nconst cssFile = process.argv[2];\nif (!cssFile) {\n  console.error(''Please provide a CSS file path'');\n  process.exit(1);\n}\n\nconst css = fs.readFileSync(cssFile, ''utf8'');\nconst minified = csso.minify(css).css;\nconst outputFile = path.basename(cssFile, ''.css'') + ''.min.css'';\nfs.writeFileSync(outputFile, minified);\nconsole.log(`Minified CSS written to ${outputFile}`);',
     '2025-01-05 10:30:00', '2025-02-20 16:15:00', 'u2', true, 3, '2.1'),

    ('s4', 'Log Rotation Script', 'log-rotation',
     E'#!/bin/bash\n# Script to rotate logs older than 7 days\nLOG_DIR="/var/log/app"\nfind $LOG_DIR -name "*.log" -type f -mtime +7 -exec gzip {} \\;\nfind $LOG_DIR -name "*.gz" -type f -mtime +30 -delete',
     '2025-01-15 09:00:00', '2025-01-15 09:00:00', 'u1', true, 4, '1.0'),

    ('s5', 'Database Backup Script', 'db-backup',
     E'#!/bin/bash\n# Script to backup PostgreSQL database and encrypt the dump\nDB_NAME="production_db"\nBACKUP_DIR="/backups"\nTIMESTAMP=$(date +"%Y%m%d_%H%M%S")\nBACKUP_FILE="$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"\n\npg_dump $DB_NAME > $BACKUP_FILE\ngpg --encrypt --recipient admin@company.com $BACKUP_FILE\nrm $BACKUP_FILE\necho "Backup created and encrypted: $BACKUP_FILE.gpg"',
     '2025-02-10 14:30:00', '2025-02-10 14:30:00', 'u1', false, 1, '1.0');

-- User-Group memberships
INSERT INTO user_group_memberships (user_id, group_id, created_at)
VALUES
    ('u1', 'g1', '2024-12-12 09:00:00'),
    ('u2', 'g1', '2024-12-13 10:15:00'),
    ('u2', 'g2', '2024-12-18 14:25:00'),
    ('u3', 'g2', '2024-12-20 09:45:00'),
    ('u1', 'g3', '2025-01-10 16:40:00');

-- Group-Script relationships
INSERT INTO group_scripts (group_id, script_id, created_at)
VALUES
    ('g1', 's1', '2024-12-14 11:20:00'),
    ('g1', 's2', '2024-12-20 15:45:00'),
    ('g1', 's4', '2025-01-15 09:00:00'),
    ('g2', 's3', '2025-01-05 10:30:00'),
    ('g3', 's5', '2025-02-10 14:30:00');

-- User's favorite scripts
INSERT INTO user_favorite_scripts (user_id, script_id, created_at)
VALUES
    ('u1', 's2', '2024-12-21 12:30:00'),
    ('u1', 's4', '2025-01-16 08:15:00'),
    ('u2', 's1', '2024-12-18 10:10:00'),
    ('u2', 's3', '2025-01-06 14:20:00'),
    ('u3', 's2', '2025-01-08 15:45:00');

-- User-Script likes
INSERT INTO user_script_likes (user_id, script_id, created_at)
VALUES
    ('u1', 's3', '2025-01-08 10:15:00'),
    ('u2', 's1', '2024-12-16 11:45:00'),
    ('u2', 's2', '2024-12-22 09:30:00'),
    ('u3', 's2', '2025-01-06 16:20:00'),
    ('u1', 's4', '2025-01-15 13:10:00'),
    ('u1', 's5', '2025-02-10 16:45:00'),
    ('u3', 's3', '2025-02-18 08:50:00'),
    ('u2', 's4', '2025-02-22 14:35:00');

-- Script tags
INSERT INTO script_tags (script_id, tag)
VALUES
    ('s1', 'aws'),
    ('s1', 's3'),
    ('s1', 'cleanup'),
    ('s1', 'devops'),
    ('s2', 'docker'),
    ('s2', 'monitoring'),
    ('s2', 'health'),
    ('s2', 'devops'),
    ('s3', 'javascript'),
    ('s3', 'css'),
    ('s3', 'minify'),
    ('s3', 'frontend'),
    ('s4', 'logs'),
    ('s4', 'maintenance'),
    ('s4', 'linux'),
    ('s4', 'devops'),
    ('s5', 'database'),
    ('s5', 'backup'),
    ('s5', 'security'),
    ('s5', 'postgresql');