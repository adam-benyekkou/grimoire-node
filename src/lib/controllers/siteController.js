import { dataMapper } from "../database/dataMapper.js";

const siteController = {
    landingPage(req, res) {
        res.render('landingPage');
    },

    loginPage(req, res) {
        res.render('loginPage');
    },

    explorePage(req, res) {
        res.render('explorePage');
    }
};

export { siteController };