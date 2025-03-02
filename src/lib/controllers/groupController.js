const groupController = {
    allGroups(req, res) {
        res.render('groups/allGroups');
    },

    singleGroup(req, res) {
        res.render('groups/singleGroup');
    },

    groupMembers(req, res) {
        res.render('groups/groupMembers');},

    groupSettings(req, res) {
        res.render('groups/groupSettings');}
}

export { groupController };