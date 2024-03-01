<template>
    <div class="content"  @dragover.prevent @drop.prevent>
        
        <Uploader v-if="uploading" v-bind:progress="Progress"  v-on:cancel="cancelUpload"/>
        <Renta v-if="inCreator" v-on:close=" inCreator = false "   v-bind:Editing="Editing" v-on:submit=" addRenta "  v-on:update="updateRenta" />
        

        <div class="title">
            <h3> Detalles del producto</h3>

            <button @click="submitData()"> Guardar </button>

            <div class="points"  @click="options = !options">
                <font-awesome-icon :icon="[ 'fas', 'ellipsis-v' ] " />
            </div>

            <div :class=" [options ? 'active' : '', 'option_bar']  ">
                <p> 
                    <font-awesome-icon :icon="[ 'fas', 'trash' ] " />
                    Eliminar video 
                    
                </p>
            </div>
        </div>

        <main>
            <section>
                <form @submit.prevent>
                    <div class="input">
                        <label for="nombre"> Titulo (Obligatorio) </label>
                        <input type="text" maxlength="40" v-model="nombre" id="nombre" autocomplete="new">
                        <p :style=" [ nombre.length == 40 ? 'color:red;' : '' ]   "> {{nombre.length}} /40</p>
                    </div>

                    <div class="input">
                        <label for="nombre"> Precio (Obligatorio) </label>
                        <input type="number" maxlength="40" v-model="precio" id="nombre" autocomplete="new">
                    </div>

                    <div class="input text">
                        <label for="desc"> Descripción (Opcional) </label>
                        <textarea v-model="desc" id="desc" maxlength="1000"></textarea>
                        <p :style=" [ desc.length >= 1000 ? 'color:red;' : '' ]   "> {{desc.length}} /1000</p>
                    </div>

                    <div class="miniatura">
                        <h4> Miniatura </h4>
                        <p>Sube una imagen para la imagen principal del producto</p>
                    </div>
                    <div class="content_min">

                        <input type="file"  @change="onImageUpload"  id="image" accept="image/png, image/gif, image/jpeg">
                        <div class="min" @click=" focusImage() ">
                            <font-awesome-icon :icon=" ['fas', 'image'] " />
                            <p>Sube una imagen</p>
                        </div>

                        <div class="image">
                            <img v-if="img" :src="img" loading="lazy">
                        </div>
                    </div>
                </form>

                <div class="renta_tool">
                    <div class="input_type" style="width: 50%;">
                    
                        <font-awesome-icon :icon=" ['fas', 'tag'] " /> 
                        <span> Renta </span>

                        <label class="switch" style="margin-left: auto;" for="checkbox">
                            <input type="checkbox"  id="checkbox" v-model="Rentas.Enabled "  />
                            <div class="slider round"></div>
                        </label>
                    </div>
                    
                    <button @click="showCreator()" v-if=" Rentas.Enabled ">
                        +
                    </button>
                </div>

                
                <div class="renta">
                    
                    <div class="table">
                        <table>
                            <tr>
                                <th> Tiempo </th>
                                <th> Precio  </th>
                                <th> Descuento </th>
                                <th> </th>
                                <th> </th>
                            </tr>
                            <tr v-for=" (item, index) in Rentas.Rentas " :key="index">
                                <td> {{item.TName}} </td>
                                <td> {{item.Precio}}$ </td>
                                <td v-if=" item.Descuento.Enabled "> Si - {{item.Descuento.Ammount}}% </td>
                                <td v-else> No </td>
                                <td>
                                    <button @click=" removeRenta(index) ">  
                                        <font-awesome-icon :icon=" ['fas', 'times'] " />
                                    </button>
                                </td>
                                <td>
                                    <button class="blue" @click=" editingRenta(index) ">  
                                        <font-awesome-icon :icon=" ['fas', 'pencil'] " />
                                    </button>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                </div>

                <br/>
            </section>

            <section>
                <div :class="[ over ? 'active' : '', file == null ? '' : 'ready', 'upload']" 
                    @dragover="onOver()" @dragleave="onLeave()" @drop="onFileChange"  @dragover.prevent @drop.prevent  @click=" showUpload() ">
                    <font-awesome-icon :icon=" ['fas', 'cloud-upload'] " />
                    <input type="file" id="fileuploader" @change="onInputChange" :accept="typeData">
                    <p> {{ file == null ? 'Arraste o de click para actualizar el archivo' : 'Archivo seleccionado' }} </p>
                    <p v-if="file !== null">  {{file.name}} </p>
                    
                </div>

                <div class="input_type" style="width: 60%;">
                    
                    <font-awesome-icon :icon=" ['fas', 'clock'] " /> 
                    
                    <span> Categoria </span>

                    <div class="custom-select" style="padding-left: 0.1vw; width: 70%; ">
                        <select v-model="category" id="category">
                            <option disabled value="">Seleccione un elemento</option>
                            <option v-for="(item, index) in categorias" :value="item._id"  :key="index"> {{item.nombre}} </option>
                        </select>
                        <span class="custom-arrow"> 
                            <font-awesome-icon :icon=" ['fas', 'angle-down'] " />
                        </span>
                    </div>
                </div>

                <div class="input_type" style="width: 50%">
                    
                    <font-awesome-icon :icon=" ['fas', 'clock'] " /> 
                    
                    <span> Visibilidad </span>

                    <div class="custom-select">
                        <select v-model="visibilidad" id="visibilidad">

                            
                            <option :value="true" >  Visible </option>
                            <option :value="false"> No listado </option>
                        </select>
                        <span class="custom-arrow"> 
                            <font-awesome-icon :icon=" ['fas', 'angle-down'] " />
                        </span>
                    </div>
                </div>

                <div class="input_type" style="width: 50%;">
                    
                    <font-awesome-icon :icon=" ['fas', 'tag'] " /> 
                    <input v-model="Descuento.Ammount" :disabled=" !Descuento.Enabled " placeholder="Descuento">

                    <label class="switch" for="descuento">
                        <input type="checkbox"  id="descuento" v-model="Descuento.Enabled "  />
                        <div class="slider round"></div>
                    </label>
                </div>
                
            </section>
        </main>

    </div>
</template>

<script>
import axios from 'axios'
import Renta from "../components//Renta.vue";
import Uploader from '../components/Upload.vue'
import { uuid } from 'vue-uuid'


export default {
    name: 'Creador_productos',
    components: {
        Renta,
        Uploader
    },
 
    data() {
        return {
            nombre: '',
            desc: '',
            precio: '',
            category: '',
            categorias: [],
            options: false,
            visibilidad: true ,
            Descuento: {
                Enabled: false,
                Ammount: ''
            },
            Rentas: {
                Enabled: false,
                Rentas: []
            },
            
            over: false,
            inCreator: false,
            Editing: null,
            currentID: undefined,
            img: undefined,
            selectFile: undefined,
            tempFile: null,
            Progress: 0,
            uploading: false,
            request: null,
            typeData: '',
            file: null
            

        }
    },
    // Sheila Yeraluw
    methods: {
        showUpload() {
            document.getElementById('fileuploader').click();
        },
        cancelUpload() {
            this.request.cancel("Cancel upload");  
        },
        submitData() {
            if(this.nombre.length == 0) return this.$root.showNotify("error", "Necesitas ingresar un nombre")
            if(this.precio.length == 0) return this.$root.showNotify("error", "Necesitas ingresar un precio")
            if(this.img == undefined) return this.$root.showNotify("error", "Necesitas subir una miniatura del archivo")
            if(this.category == '') return this.$root.showNotify("error", "Necesitas seleccionar una categoria")
            
            const fd = new FormData();

            const data = {
                id: this.$route.params.id,
                nombre: this.nombre,
                precio: this.precio,
                desc: this.desc,
                category: this.category,
                Rentas: this.Rentas,
                Descuento: this.Descuento,
                visibilidad: this.visibilidad,
                
            }

            fd.append('data', JSON.stringify(data));
            if(this.selectFile !== undefined) fd.append('imagen', this.selectFile);
            if(this.file !== null) fd.append('file', this.file)

            this.uploading = true;

            const axiosSource = axios.CancelToken.source();

            this.request = { cancel: axiosSource.cancel, msg: "Loading..." };
            axios.post(`/api/${this.$route.params.type}/update`, fd, {
                cancelToken: axiosSource.token,
                onUploadProgress: function( progressEvent ) {
                    this.Progress = parseInt( Math.round( ( progressEvent.loaded / progressEvent.total ) * 100 ) );
                }.bind(this)
            } ).then(res => {

                if(res.data == "success") {

                    this.$root.showNotify('info', "Created success");
                }
            }).catch((err) => {
                console.log(err);
            })
        },
        showCreator() {
            this.Editing = null;
            this.inCreator = true;
            this.currentID = undefined;
        },
        focusImage() {
            document.getElementById( 'image' ).click()
        },
        uploadFile() {
            document.getElementById("fileuploader").click();
        },

        addRenta(obj) {
            obj.ID = uuid.v4();
            this.Rentas.Rentas.push( obj )
        },
        removeRenta(index) {
            this.Rentas.Rentas.splice(index, 1);
        },
        updateRenta(obj) {
            const ID = this.currentID;
            const find = this.Rentas.Rentas.findIndex( o => o.ID == ID );

            if(find == -1) return;

            this.Rentas.Rentas[find] = obj;

        },
        editingRenta(index) {
            this.inCreator = true;
            this.currentID = this.Rentas.Rentas[index].ID;
            this.Editing = this.Rentas.Rentas[index];
        },
        onOver() {
            this.over = true;
        },
        onLeave() {
            this.over = false;
        },
        onImageUpload: function(e) {
            const file = e.target.files[0];
            this.selectFile = file;
            this.img = URL.createObjectURL(file);  
        },
        onInputChange(e) {
            const file = e.target.files[0];
            this.file = file;
        },
        onFileChange(e) {
            this.over = false;
            const file = e.dataTransfer.files[0];
            this.file = file;

            //this.$emit('updateDocument', file)
        },
        


    },
    mounted() {

        if(this.$route.params.type == 'productos' ) this.typeData = "video/*"
        else this.typeData = ".pdf"
        axios.post( `/api/${this.$route.params.type}/${ this.$route.params.type == 'docs' ? 'doc' : 'producto' } `, { id: this.$route.params.id }  ).then((res) => {
            const item = res.data;

            this.img = `${axios.defaults.baseURL}/api/productos/image/${item._id}`
            this.nombre = item.nombre
            this.precio = item.price
            this.desc = item.descripcion;
            this.category = item.categoria
            this.Descuento = item.discount;
            this.Rentas = item.rentas 
            this.visibilidad = item.visible
        })
        
        axios.get('/api/category').then(res => {

            this.categorias = res.data;
        }).catch(() => {

        })
    }
}
</script>

<style lang="scss" scoped>

@mixin center() {
    display: flex;
    justify-content: center;
    align-items: center;
}

.content {
    width: 100vw;
    height: auto;
    background: #EFEFEF;
    padding-top: 10vh;
    * {
        font-family: 'Manrope', sans-serif ;
    }
    user-select: none;
    .title {

        width: 82%;
        height: 6vh;
        background: transparent;
        display: flex;
        align-items: center;
        position: relative;
        
        button {
            margin-left: auto;
            height: 4.70vh;
            width: 6.5rem;
            background: var(--col-green);
            color: white;
            font-size: 1rem;
            font-weight: bold;
            margin-right: 0.5vw;
            cursor: pointer;
        }

        .points {
            width: 2rem;
            height: 70%;
            border-radius: 1rem;
            font-size: 1.2rem;
            color: rgb(112, 112, 112);
            transition: all 0.2s;
            @include center();

            &:hover {
                color: black;
            }

            &:active {
                
                background: rgba(128, 128, 128, 0.336);
            }
        }

        .option_bar {
            position: absolute;
            right: 1px;
            
            transform: translate(( calc(2rem + 6.5rem) ), 6vh);
            width: 10vw;
            height: 6vh;
            background: white;
            @include center();
            box-shadow: 0px 0.5px 4px rgba(0, 0, 0, 0.432);
            display: none;

            animation: anim 0.2s ;
            p {
                width: 100%;
                height: 4vh;
                transition: all 0.2s;
                @include center();
                cursor: pointer;
                svg {
                    padding-right: 0.5vw;
                }
                &:hover {
                    background: rgba(128, 128, 128, 0.137);
                }
            }
            

            @keyframes anim {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            &.active {
                display: flex;
            }
        }
    }

    main {
        
        width: 100%;
        height: 90%;
        display: flex;
        margin-top: 1vh;
        overflow: auto;
        background: #EFEFEF;
        padding-bottom: 5vh;
        section {
            width: 47%;
            height: auto;
            background: #EFEFEF;
            padding-bottom: 5vh;

            
            .preview {
                width: 22vw;
                height: 30vh;
                background: transparent;
                @include center();
                video, embed {
                    max-height: 100%;
                }
            }

            &:nth-child(2) {
                background: transparent;
                width: 35%;
            }

            .input {
                display: flex;
                flex-direction: column;
                width: 90%;
                height: 10vh;
                border: 0.2px solid rgba(46, 46, 46, 0.37);
                padding-left: 1vw;
                padding-top: 0.5vh;
                transition: all 0.2s ;
                margin-top: 2vh;
                position: relative;
                border-radius: 0.3rem;
                

            
                &.text {
                    height: 27vh !important;
                }

                &.colored {
                    background: rgb(146, 146, 146);
                    cursor: not-allowed;
                }

                &:nth-of-type(1) {
                    margin-top: 2vh;
                }


                &:focus-within {
                    border: 0.2px solid rgba(131, 63, 241, 0.37);

                    label {
                        color: rgba(131, 63, 241, 0.829);
                    }

                    p {
                        display: block;
                    }
                }

                label {
                    color: rgb(29, 29, 29);
                    transition: all 0.2s ;
                    @include center();
                    justify-content: flex-start;
                }

                

                input[type=checkbox] {
                    margin-left: 1vw;
                    margin-top: 3px;
                }


                input, textarea, select {
                    height: 60%;
                    background: transparent;
                    resize: none;

                    &:disabled {
                        cursor: not-allowed;
                    }
                    
                }

                textarea {
                    background: transparent;
                    width: 94%;
                    height: 73%;
                    padding-top: 1vh;
                }
                span {
                    position: absolute;
                }

                p {
                    position: absolute;
                    bottom: 0.3rem;
                    right: 1rem;
                    font-size: 0.8rem;
                    display: none;
                }

                
            }

            .input_type {
                margin-top: 3vh;
                background: var(--bg-body);
                padding: 0.5rem;
                display: flex;
                align-items: center;
                border-radius: 0.7rem;
                height: 7vh;
                position: relative;
                

                svg {
                    position: absolute;
                    color: var(--bg-gray);
                }

                span {
                    margin-left: 1.5vw;
                    font-size: 0.8rem;
                }

                input {
                    background: transparent;
                    height: 100%;
                    width: 100%;
                    padding-left: 2rem;

                    &::placeholder {
                        color: var(--bg-gray);
                    }

                    &:disabled {
                        cursor: not-allowed;
                    }
                }

                .custom-select {
                    
                    display: flex;
                    position: relative;
                    width: 8rem;
                    height: 100%;
                    background: white;
                    border-radius: 1rem;
                    @include center();
                    margin-left: auto;
                    border: none;
                    transform: translate(0, -0.5vh);

                    select {
                        
                        font-size: 0.8rem;
                        padding: 0 1rem;
                        background: transparent;
                        color: black;
                        appearance: none;
                        border: 0;
                        width: 15rem;
                        height: 100%;
                        
                        
                    }

                    .custom-arrow {
                        
                        position: absolute;
                        background: transparent;
                        display: flex;
                        width: 5rem;
                        height: 100%;
                        pointer-events: none;
                        
                        
                        top: 0;
                        right: 0;

                        @include center();

                        svg {
                            font-size: 1.3rem;
                            color: black;
                        }

                    }
                }

                .switch {
                    display: inline-block;
                    height: 2rem;
                    position: relative;
                    width: 4rem;

                    input {
                        display:none;
                    }

                    .slider {
                        background-color: #ccc;
                        bottom: 0;
                        cursor: pointer;
                        left: 0;
                        position: absolute;
                        right: 0;
                        top: 0;
                        transition: .4s;
                    }

                    .slider:before {
                        background-color: #fff;
                        bottom: 0.2rem;
                        content: "";
                        height: 1.6rem;
                        left: 0.3rem;
                        position: absolute;
                        transition: .4s;
                        width: 1.6rem;
                    }

                    input:checked + .slider {
                        background-color: #66bb6a;
                    }

                    input:checked + .slider:before {
                        transform: translateX(1rem);
                    }

                    .slider.round {
                        border-radius: 34px;
                    }

                    .slider.round:before {
                        border-radius: 50%;
                    }

                }
            }

            


            .custom-select {
                margin-top: 1vh;
                display: flex;
                position: relative;
                width: 15rem;
                border: 1px solid rgba(53, 53, 53, 0.63);
                
                select {
                    
                    font-size: 1rem;
                    padding: 0.8rem 5rem 0.8rem 1.5rem;
                    background: transparent;
                    color: black;
                    appearance: none;
                    border: 0;
                    width: 15rem;
                }

                .custom-arrow {
                    
                    position: absolute;
                    background: transparent;
                    display: flex;
                    width: 5rem;
                    height: 100%;
                    pointer-events: none;
                    
                    top: 0;
                    right: 0;

                    @include center();

                    svg {
                        font-size: 1.3rem;
                        color: black;
                    }

                    
                    
                    

                }
            }

            .renta_tool {
                margin-top: 3vh;
                display: flex;
                align-items: center;
                
                width: 70%;
                height: 7vh;
                background: transparent;
                padding-right: 1vw;

                .input_type {
                    margin-top: 0;

                    span {
                        font-size: 0.9rem;
                    }
                }

                button {
                    margin-left: auto;
                    width: 2.5rem;
                    height: 80%;
                    background: var(--col-green);
                    color: white;
                    height: 2rem;
                    border-radius: 0.3rem;
                    cursor: pointer;
                    transition: transform 0.2s;
                    &:hover {
                        transform: scale(1.2)
                    }
                    @include center();
                }
            }

            .renta {
                margin-top: 1.5vh;
                height: 35vh;
                background: transparent;
                width: 70%;
                box-shadow: 0px 1px 10px rgba(0, 0, 0, 0.199);
                
                table {
                    width: 100%;
                    text-align: left;
                    border-collapse: collapse;
                    th, td {
                        font-weight: lighter;
                        padding: 0.5rem 1rem;
                        user-select: none;
                    }
                    th {
                        font-weight: bold;
                    }
                    tr:nth-child(even) {
                        background-color: #ececec ;
                    }

                    button {
                        padding: 0.5rem 1rem;
                        background: var(--col-red);
                        border-radius: 0.3rem;
                        color: white;
                        cursor: pointer;

                        &.blue {
                            background: var(--col-blue);
                        }
                    }
                }
            }

            .miniatura {
                margin-top: 1vh;
            }

            .content_min {
                width: 25vw;
                height: 13vh;
                display: flex;

                input {
                    display: none;
                }
                .min {
                    margin-top: 0.5rem;
                    width: 10vw;
                    height: 13vh;
                    border: 0.2px solid rgba(46, 46, 46, 0.37);
                    cursor: pointer;
                    svg {
                        font-size: 1.5rem;
                    }
                    @include center();
                    flex-direction: column;
                    p {
                        font-size: 0.9rem;
                    }
                }

                .image {
                    margin-left: 1vw;
                    margin-top: 0.5rem;
                    height: 100%;
                    width: 13vw;
                    @include center();

                    img {
                        max-height: 100%;
                    }
                }
            }

            .upload {
                width: 70%;
                height: 30vh;
                background: transparent;
                border: 3px dashed rgb(163, 163, 163);
                cursor: pointer;
                margin-top: 2vh;
                input[type=file] {
                    display: none;
                }

                transition: all 0.2s ease;
                @include center();
                flex-direction: column;

                p {
                    color: #636363;
                    transition: color 0.2s ease;
                }
                svg {
                    font-size: 3rem;
                    transition: color 0.2s ease;
                    color: #636363;
                }

                @keyframes jump {
                    0% {
                        transform: translate(0, 0);
                    }
                    
                    50% {
                        transform: translate(0, -2vh);
                    }
                    100% {
                        transform: translate(0, 0);
                    }
                }

                &.active {
                    border: 3px dashed black;
                    svg {
                        animation: jump 0.7s infinite;
                        color: black;
                    }
                    p {
                        color: black;
                    }
                }

                &.ready {
                    border: 3px dashed var(--col-green);
                    svg {
                        color: var(--col-green) !important; 
                    }
                }
            }
        }

    }
    
}
</style>