import { dataMapper } from "../database/dataMapper.js";

const scriptController = {
    async allScripts(req, res, next) {
        try {
            const allScripts = await dataMapper.getAllScripts();
            console.log(allScripts);
            res.render('scripts/myScripts', { allScripts});
        } catch (error) {
            next(error);
        }

    },

    singleScript(req, res) {
        res.render('scripts/singleScript');
    },

    newScript(req, res) {
        res.render('scripts/newScript');
    },

    scriptSettings(req, res) {
        res.render('scripts/scriptSettings');
    }
};

export { scriptController };