import 'dotenv/config';
import path from "path";
import express from "express";
const app = express();
import { router } from "./src/router.js";
import { notFound } from './src/lib/middlewares/errors/notFound.js';
import { errorHandler } from './src/lib/middlewares/errors/errorHandler.js';

// EJS CONFIG
const __dirname = import.meta.dirname;
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));


// Statics Config
app.use(express.static(path.join(import.meta.dirname, 'assets')));

app.use(router);

//Ajouter error handlers middleware
app.use(notFound);
app.use(errorHandler);

const port = process.env.PORT || 3000;
const base_url = process.env.BASE_URL;


app.listen(port, () => console.log(`Listening on ${base_url}:${port}`));