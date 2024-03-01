import express from 'express';
import Post from '../models/Post';

import sharp from 'sharp';


const compressImage = async (imagePath:string, name: string) => {

    const image = sharp(imagePath);
    image.resize(200);
    
    await image.toFile( process.cwd() +"/public/optimize/"+ name );
}

export async function create(req: express.Request, res: express.Response) {
    const { title, section, description, details, location, multilocation, contact} = JSON.parse(req.body.data);


    const file = req.file;

    //await compressImage(file?.path ?? '', file?.filename ?? '');
    const post = new Post({
        title,
        section,
        description,
        details,
        location,
        multilocation,
        contact,
        image: file?.filename,
    });


    const guardarPost = await post.save();
    
    res.status(200).json(guardarPost)
}



export async function get(req: express.Request, res: express.Response) { 
    const { section, trending } = req.query;
    
    try {
        if(section) {

            const list = await Post.find( { section: section } );
            res.status(200).json(list)
            return;
        }

        if(trending) {
            const list = await Post.find( { trending: true } );
            res.status(200).json(list)
            return;
        }

        const list = await Post.find();
        res.status(200).json(list);
        
    } catch (error) {
        
        res.status(402).json("Something workng")
    }
}

export async function remove(req: express.Request, res: express.Response) {

    const id = req.params.id
    try {
        const post = await Post.findOne( { _id: id } )
        post?.deleteOne()

        res.status(200).json("OK")
    } catch (error) {
        res.status(402).json("Something workng")
    }
}

export async function update(req: express.Request, res: express.Response) {

    const id = req.params.id;
    const { title, section, description, details, location, contact } = req.body;

    try {
        const post = await Post.findOne( { _id: id } )

        post?.updateOne({
            title, section, description, details, location, contact 
        })
        res.status(200).json("OK")
    } catch (error) {
        res.status(402).json("Something workng")
    }
}


export async function star(req: express.Request, res: express.Response)  {

    const { id } = req.body;
    const find = await Post.findById(id);
    if(!find) return res.status(404).json({ message: "No se encontró el evento" });
    
    find.trending = !find.trending;
    await find.save();
    res.status(200).json(find);

}
