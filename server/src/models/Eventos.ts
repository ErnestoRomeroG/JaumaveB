
import { prop, getModelForClass } from '@typegoose/typegoose';

class Eventos {
    @prop()
    public name?: string;

    @prop() 
    public location?: string;

    @prop()
    public details?: string;

    @prop()
    public image?: string;

    @prop()
    public day?: string;
    

    @prop()
    public month?: string;

    @prop() 
    public date?: Date

    @prop() 
    public time?: string


}

export default getModelForClass(Eventos);

