import {dataMapper} from "../database/dataMapper.js";

const groupController = {
    async allGroups(req, res, next) {
        try {
            const allGroups = await dataMapper.getAllGroups();
            console.log(allGroups);
            res.render('groups/allGroups', { allGroups });

        } catch (error) {
            next(error);
        }

    },

    async singleGroup(req, res, next) {
        try {
            const allGroups = await dataMapper.getAllGroups();
            const currentGroup = allGroups.find(group => group.id ===  req.params.id);


            if (currentGroup.length === 0) {
                return res.status(404).render("error", { message: 'No matching scripts found' });
            }

            console.log(currentGroup);
            res.render('groups/singleGroup', { currentGroup });
        } catch (error) {
            next(error);
        }
    },



    groupMembers(req, res) {
        res.render('groups/groupMembers');},

    groupSettings(req, res) {
        res.render('groups/groupSettings');}
}

export { groupController };