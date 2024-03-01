import express from 'express';
import Evento from '../models/Eventos'
import sharp from 'sharp';


const compressImage = async (imagePath:string, name: string) => {

    const image = sharp(imagePath);
    image.resize(200);
    
    await image.toFile( process.cwd() +"/public/optimize/"+ name );
}



export async function create(req: express.Request, res: express.Response) {
    const { name, location, date, details, time} = JSON.parse(req.body.data)

    const file = req.file;

    //await compressImage(file?.path ?? '', file?.filename ?? '');

    const meses = ["Enero", "Feb", "Mar", "Abril", "Mayo", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"];
    const fecha = new Date(date)
    const event  = new Evento(
        {
            name,
            details,
            location, 
            image: file?.filename,
            day: fecha.getDate(),
            month: meses[fecha.getMonth()],
            date: fecha,
            time: time
        }
    )

    const save_data = await event.save();
    res.status(200).json(save_data);
}




export async function get(req: express.Request, res: express.Response)  {

    let find = await Evento.find();
    find.sort((a: any, b: any) => a.date - b.date);

    if (req.query.date == 'now') {
        const currentEvents = find.filter((evento: any) => {
            const now = new Date();
            const diff = evento.date.getTime() - now.getTime();
            const days = Math.ceil(diff / (1000 * 3600 * 24));
            return days <= 7 && days > 0;
        });
        return res.status(200).json(currentEvents);
    }

    if(req.query.date == 'soon') {
            
        const currentEvents = find.filter( (evento: any) => {
            const now = new Date();
            const diff = evento.date.getTime() - now.getTime();
            const days = Math.ceil(diff / (1000 * 3600 * 24));
            return days > 7;
        })

        return res.status(200).json(currentEvents);
    }

    if(req.query.trending == 'true') { 

        const trending = find.filter( (evento: any) => evento.trending == true );
        return res.status(200).json(trending);
    }

    res.status(200).json(find);
}




export async function remove(req: express.Request, res: express.Response)   {

    const { id } = req.params;

    console.log(id)

    const find = await Evento.findById(id);
    if(!find) return res.status(404).json({ message: "No se encontró el evento" });

    find.deleteOne();

    res.status(200).json({ message: "Evento eliminado" });

}