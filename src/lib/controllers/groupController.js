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

    singleGroup(req, res) {
        res.render('groups/singleGroup');
    },

    groupMembers(req, res) {
        res.render('groups/groupMembers');},

    groupSettings(req, res) {
        res.render('groups/groupSettings');}
}

export { groupController };