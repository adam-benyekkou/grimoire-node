const scriptController = {
    allScripts(req, res) {
        res.render('scripts/myScripts');
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