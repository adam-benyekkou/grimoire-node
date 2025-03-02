import pg from 'pg';

const client = new pg.Client(process.env.PG_URL);

// on connecte à la BDD : si une erreur se produit, on coupe le client
client.connect(err => {
    if(err) {
        console.log('callback', err.message);
        client.end();
    }
});


export { client };