

import app from './src/app'
import express from 'express'
import './src/db'
import dotenv from 'dotenv';

dotenv.config()

app.listen(3000, async () => {
    console.log(`\x1b[35mEl servidor fue iniciado con éxito en 3000 \x1b[39m`);
} );

app.use(express.static(`${__dirname}/public`));


let data = new Date();

console.log(data.getMonth())
console.log(data.getDate());
//data.getUTCDay

import Post from './src/routes/Post'
import Event from './src/routes/Event'

app.use("/api/post", Post);
app.use("/api/eventos", Event)


