import { dataMapper } from "../database/dataMapper.js";

const scriptController = {
    async allScripts(req, res, next) {
        try {
            const allScripts = await dataMapper.getAllScripts();
            console.log(allScripts);
            res.render('scripts/myScripts', { allScripts });
        } catch (error) {
            next(error);
        }

    },

    async singleScript(req, res, next) {
        try {
            const allScripts = await dataMapper.getAllScripts();
            const currentScript = allScripts.find(script => script.id ===  req.params.id);


            if (currentScript.length === 0) {
                return res.status(404).render("error", { message: 'No matching scripts found' });
            }

            console.log(currentScript);
            res.render('scripts/singleScript', { currentScript });
        } catch (error) {
            next(error);
        }
    },

    newScript(req, res) {
        res.render('scripts/newScript');
    },

    async scriptSettings(req, res, next) {
        try {
            const allScripts = await dataMapper.getAllScripts();
            const currentScript = allScripts.find(script => script.id === req.params.id);


            if (currentScript.length === 0) {
                return res.status(404).render("error", { message: 'No matching scripts found' });
            }

            console.log(currentScript);
            res.render('scripts/scriptSettings', { currentScript });
        } catch (error) {
            next(error);
        }
    }
};

export { scriptController };