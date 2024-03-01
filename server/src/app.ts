import express, { Application } from 'express'
import cors from 'cors'
import cookieParser from 'cookie-parser';
import https from 'https';
import fs from 'fs';

const app: Application = express();

app.use(express.static(__dirname));
app.use(express.urlencoded({extended: false}))



app.set('trust proxy', 1)
app.use(cookieParser());
app.use( express.json())

app.use(cors({
    origin: ['https://nethzel.com', 'http://localhost:5173' ],
    methods: ["GET", "POST", "DELETE", "PUT"],
    credentials: true,
    exposedHeaders: ['token'],
    
    
}));

/*
let privateKey  = fs.readFileSync('./privkey.pem');
let certificate = fs.readFileSync('./fullchain.pem');

let credentials = {key: privateKey, cert: certificate};

const httpsServer = https.createServer(credentials, app);
httpsServer.listen(8463);*/

export default app;



