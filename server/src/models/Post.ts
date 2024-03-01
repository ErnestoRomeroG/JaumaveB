import { prop, getModelForClass } from '@typegoose/typegoose';



type categorias = 'Hospedaje' | 'Gastronomia' | 'Biodiversidad' | 'Artesanos' | 'Emblematicos'

class Publicaciones {

    @prop() 
    public title?: string;

    @prop()
    public section?: categorias

    @prop() 
    public description?: string;

    @prop() 
    public image?: string;

    @prop() 
    public details?: string;

    @prop() 
    public location?: string;

    @prop() 
    public multilocation?: boolean;

    @prop() 
    public contact?: string;

    @prop( { default: false })
    public trending?: boolean 

}


export default getModelForClass(Publicaciones);