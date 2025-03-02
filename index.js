import 'dotenv/config';
import path from "path";
import express from "express";
const app = express();
import { router } from "./src/router.js";
//Controllers  are importer

// EJS CONFIG
const __dirname = import.meta.dirname;
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));


// Statics Config
app.use(express.static(path.join(import.meta.dirname, 'assets')));

app.use(router);

//Ajouter error handlers middleware


const port = process.env.PORT || 3000;
const base_url = process.env.BASE_URL;


app.listen(port, () => console.log(`Listening on ${base_url}:${port}`));