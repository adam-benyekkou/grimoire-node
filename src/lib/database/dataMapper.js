import { client } from "./client.js";


const dataMapper = {

    async getAllScripts(){
        const query = "SELECT * FROM scripts";
        const result = await client.query(query);
        return result.rows;
},

    async getAllGroups(){
        const query = "SELECT * FROM groups";
        const result = await client.query(query);
        return result.rows;
    },

    async getAllProfiles(){
        const query = "SELECT * FROM users";
        const result = await client.query(query);
        return result.rows;
    }

};

export { dataMapper };