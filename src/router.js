import { Router } from "express";
const router = Router();
import { siteController } from './lib/controllers/siteController.js';
import {scriptController} from "./lib/controllers/scriptController.js";
import { profileController } from "./lib/controllers/profileController.js";
import { groupController } from "./lib/controllers/groupController.js";

router.get('/', siteController.landingPage);
router.get('/login', siteController.loginPage);
router.get('/explore', siteController.explorePage);

router.get('/scripts', scriptController.allScripts);
router.get('/scripts/new', scriptController.newScript);
router.get('/scripts/:id', scriptController.singleScript);
router.get('/scripts/:id/settings', scriptController.scriptSettings);

//Ajouter les collections

router.get('/groups', groupController.allGroups);
router.get('/groups/:id', groupController.singleGroup);
router.get('/groups/:id/members', groupController.groupMembers);
router.get('/groups/:id/settings', groupController.groupSettings);

router.get('/profile/:id', profileController.singleProfile);
router.get('/myprofile', profileController.myProfile);
router.get('/myprofile/settings', profileController.profileSettings);



// router.get('/api', (req, res) => {});

export { router };

/*
/                 # Landing page/dashboard
/login            # Authentification
/scripts          # Liste de mes scripts
/scripts/new      # Création d'un nouveau script
/scripts/[id]     # Éditeur/visualiseur de script
/scripts/[id]/settings # Paramètres du script (permissions, etc.)
/groups           # Mes groupes
/groups/[id]      # Dashboard d'un groupe
/groups/[id]/members # Gestion du groupe et de ses membres
/groups/[id]/settings # Gestion du groupe et de ses membres
/explore          # Découverte de scripts publics
/profile          # Mon profil
/profile/settings # Paramètres du compte
/api/*            # Routes API
*/
