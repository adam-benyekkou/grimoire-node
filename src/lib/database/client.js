import pg from 'pg';
const { DB_HOST, DB_USERNAME, DB_PASS, DB_NAME } = process.env;
const connectionString = `postgres://${DB_USERNAME}:${DB_PASS}@${DB_HOST}/${DB_NAME}`;

const client = new pg.Client(connectionString);

// on connecte à la BDD : si une erreur se produit, on coupe le client
client.connect(err => {
    if(err) {
        console.log('callback', err.message);
        client.end();
    }
});


export { client };