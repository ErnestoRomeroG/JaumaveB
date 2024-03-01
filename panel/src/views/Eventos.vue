<template>
    <div class="content"   @dragover.prevent @drop.prevent>
        <!-- Inbox v-if="viewMessage" v-on:close="viewMessage = false"  /> -->
        <div class="cartel">
            <div class="flex">
                <div class="box">
                    <h1>Administrador de eventos</h1>

                    <p>
                        Bienvenido al panel. <br />
                        Agrega un ítem para la pestaña eventos. Ingresa el nombre,
                        lugar, los detalles, fecha y hora.

                    </p>
                </div>
            </div>
        </div>
        <div class="contenido">
            <Model v-bind:title="''" class="table" style="width: 25vw; height: 60vh" >
                <div class="users">
                    <div class="search">
                        <font-awesome-icon :icon="['fas', 'edit']" />
                        <input type="text" v-model="title" placeholder="Titulo" />
                    </div>
                </div>

                <div class="users">
                    <div class="search">
                        <font-awesome-icon :icon="['fas', 'location-pin']" />
                        <input type="text" v-model="location" placeholder="Localización" />
                    </div>
                </div>

                <div class="users">
                    <div class="search">
                        <font-awesome-icon :icon="['fas', 'sign']" />
                        <textarea  v-model="details"  placeholder="Detalles"></textarea>
                    </div>
                </div>


                <div class="users">
                    <div class="search">
                        <font-awesome-icon :icon="['fas', 'calendar']" />
                        <input type="date" v-model="fecha"  />
                    </div>
                </div>

                <div class="users">
                    <div class="search">
                        <font-awesome-icon :icon="['fas', 'clock']" />
                        <input type="time" v-model="time"  />
                    </div>
                </div>
                



                <div class="botones">
                    
                    <input type="file" id="fileuploader" @change="onImageUpload" accept="image/*">
                    <button @click=" showUploader()  "> 
                        <p v-if="img == undefined">IMAGEN</p> 
                        <p v-else> <font-awesome-icon :icon=" [ 'fas', 'check'] " /> </p>
                    </button>

                </div>

                <button class="success" @click="submit" >Enviar</button>
            </Model>
        
            <div class="cards">
                <div class="rounded" v-for="(item, index) in eventos" :key="index">
                    <div class="title">
                        <div class="info">
                            <h3> {{item.name}} </h3>
                        </div>
                        <div class="buttons">

                            <div class="button" @click=" removeEvento(item._id) ">
                                <font-awesome-icon :icon="['fas', 'times']" />
                            </div>
                        </div>
                    </div>
                </div>
            </div> 


        </div>
        <!--
        <div class="cards">
            <Advice color="#26de5a" title="Usuarios totales" :info="userCount">
                <font-awesome-icon :icon="['fas', 'user']" />
            </Advice>
        </div> -->
    </div>
</template>

<script>
import axios from "axios";
import Model from "../components/Model.vue";
import Advice from "../components/Advice.vue";
import { uuid } from 'vue-uuid'
axios.defaults.withCredentials = true
//import Inbox from '../components/Ticket.vue'
export default {
    name: "Home",
    components: {
        Model,
        Advice,
        
    },
    data() {
        return {
            title: '',
            desc: '',
            details: '',
            section: '',
            location: '',
            fecha: '',
            multiplelocation: '',
            contact: '',
            img: null,
            file: null,
            selectFile: null,
            eventos: [],
            time: ''
        };
    },
    methods: {
        updateStar(id) {
            axios.put(`/api/eventos/`, { id: id } ).then((res) => {

                this.$root.showNotify('success', 'Se ha actualizado el evento')
                
                this.eventos = this.eventos.map((item) => {
                    if(item._id == id) {
                        item.trending = !item.trending
                    }
                    return item
                })
            })
        },
        removeEvento(id) {

            axios.delete(`/api/eventos/${id}`, ).then((res) => {

                this.$root.showNotify('success', 'Se ha eliminado el evento')
                
                this.eventos = this.eventos.filter((item) => {
                    if(item._id != id) {
                        return item
                    }
                })
            })
        },
        showFile() {
            document.getElementById('file').click()
        },
        showUploader() {
            document.getElementById('fileuploader').click()
        },
        onImageUpload (e) {
            
            const file = e.target.files[0];
            this.selectFile = file;
            this.img = URL.createObjectURL(file);

        },
        submit() {

            


            if(this.title == '' ) return this.$root.showNotify('error', 'Necesitas llenar el titulo ');
            if(this.location == '') return this.$root.showNotify('error', 'Necesitas una localización ');
            if(this.details == '' ) return this.$root.showNotify('error', 'Necesitas agregar detales ');
            if(this.fecha == '') return this.$root.showNotify('error', 'Necesitas agregar una fecha ');
            if(this.img == '') return this.$root.showNotify('error', 'Necesitas subir una imagen ');
            //if(this.image_data.length == 0) this.$root.showNotify('error', 'Necesitas subir fotos de muestra')
            const fd = new FormData();

            const fecha = new Date(this.fecha)
            let fechaCampo = new Date(fecha);

            // Ajustar la fecha a la zona horaria local
            const fechaAjustada = new Date(fechaCampo.getTime() + fechaCampo.getTimezoneOffset() * 60000);

            const data = {
                name: this.title,
                location: this.location,
                details: this.details,
                date: fechaAjustada,
                time: this.time
            }

            //title, section, description, details, locaiton, multilocation, contact

            fd.append("data", JSON.stringify(data));
            fd.append('image', this.selectFile);

            axios.post("/api/eventos", fd).then((res => {
                this.$root.showNotify('success', 'Se ha agregado el evento')
                this.eventos.push(res.data)
                this.title = ''
                this.location = ''
                this.details = ''
                this.fecha = ''
                this.img = null
                this.time = ''
            }))
        },
    },
    mounted() {
        axios.get("/api/eventos/").then((res) => {
                this.eventos = res.data;
                
            })
    },
};
</script>

<style lang="scss" scoped>
.content {
    width: 100vw;
    height: 91vh;
    background: var(--bg-content);

    h3,
    h2,
    h1 {
        font-family: "IBM Plex Sans Thai Looped", sans-serif;
    }

    .checks {
                margin-top: 1vh;
                display: flex;
                justify-content: space-between;
                font-family: 'Roboto', sans-serif;
                label {
                    font-size: 0.9rem;
                    margin-left: 10px;
                    color: gray;
                }

                input[type=checkbox] {
                    
                    accent-color: var(--bg-purple);
                }
            }

    .cards {
        
        padding: 3vh;
        background: transparent;
        width: 70%;

        .card {
            margin-left: 2vw;

            &:first-child,
            &:nth-child(3) {
                margin-left: 0;
            }
        }
    }

    .cartel {
        width: 98%;
        height: 25vh;
        background: linear-gradient(
            152deg,
            rgba(147, 87, 238, 1) 0%,
            rgba(192, 150, 255, 1) 100%
        );
        padding: 1vh 1.5rem;
        border-radius: 0.3rem;

        .flex {
            width: 100%;
            height: 100%;
            display: flex;
            color: white;
            font-family: "Segoe UI", "Roboto", "Helvetica Neue", Arial,
                sans-serif;
            .box {
                width: 90%;
                height: 100%;
                background: transparent;
                display: flex;
                flex-direction: column;
                padding-bottom: 5vh;

                img {
                    height: 90%;
                    transform: translate(0, 2vh);
                }
                p {
                    margin-top: auto;
                    max-width: 70%;
                    font-size: 1.3rem;
                }

                &:nth-of-type(2) {
                    width: 30%;
                    height: 100%;
                    margin-left: auto;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
            }
        }
    }

    .contenido {
        width: 100%;
        background: transparent;
        display: flex;
        flex-wrap: wrap;
        align-content: flex-start;

        .table {
            background: var(--headers);
            color: white;
            
            table {
                overflow: auto;
                margin-top: 2vh;
                width: 97%;
                text-align: left;
                border-collapse: collapse;
                color: white;
                font-family: "Manrope", sans-serif;

                th,
                td {
                    padding: 0.7rem;
                    font-size: 0.9rem;
                    text-transform: uppercase;
                }

                @media screen and (max-width: 1500px) {
                    font-size: 0.7rem;

                    th,
                    td {
                        padding: 0.35rem;
                    }
                }

                tr {
                    background: var(--bg-purple);
                    &:nth-child(even) {
                        background: var(--low-purple);
                    }
                }

                button {
                    padding: 0.5rem 1rem;
                    color: white;
                    background: var(--col-blue);
                    border-radius: 0.3rem;
                    cursor: pointer;

                    @media screen and (max-width: 768px) {
                        padding: 0.3rem 0.5rem;
                        font-size: 0.7rem;
                    }
                }
            }
        }

        .filters {
            width: 95%;
            height: 5vh;
            background: transparent;
            padding-top: 1vh;
            .fil {
                width: 4vw;
                height: 2.5vh;
                display: flex;
                background: var(--bg-purple);
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 10px;
                p {
                    margin-left: 0.3vw;
                    font-family: "Roboto", sans-serif;
                    font-size: 0.8rem;
                }
            }
        }

        .line {
            width: 95%;
            height: 1px;
            background: gray;
            margin-top: 2vh;
        }

        .users {
            margin-top: 2vh;
            position: relative;
            .button {
                margin-left: 1vw;
                width: 2rem;
                height: 2rem;
                background: var(--bg-purple);
                border-radius: 0.3rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1rem;
                position: relative;
                margin-top: auto;
                cursor: pointer;
                .counter {
                    width: 1.1vw;
                    height: 2.1vh;
                    position: absolute;
                    top: 0;
                    transform: translate(1.1vw,-1vh);
                    background: linear-gradient(90deg, #4b6cb7 0%, #32559b 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 10px;

                    
                    p {
                        font-size: 0.9rem;
                        font-weight: bold;
                    }
                    
                }
            }
                    

            .search {
                margin-top: 1vh;
                width: 100%;
                background: var(--bg-body);
                padding: 0.5rem;
                display: flex;
                align-items: center;
                border-radius: 0.7rem;
                height: 60%;
                svg {
                    position: absolute;
                    color: var(--bg-gray);
                }

                input, textarea{
                    background: transparent;
                    height: 100%;
                    width: 100%;
                    padding-left: 1.5rem;
                    color: white;

                    &::placeholder {
                        color: var(--bg-gray);
                    }
                }
                textarea {
                    resize: none;
                    
                }
            }

            input[type="range"] {
                width: 95%;
                background-color: red;
            }

            .checks {
                margin-top: 1vh;
                display: flex;
                justify-content: space-between;
                font-family: "Roboto", sans-serif;
                label {
                    font-size: 0.9rem;
                    margin-left: 10px;
                    color: gray;
                }

                input[type="checkbox"] {
                    accent-color: var(--bg-purple);
                }
            }
        }


        .botones {
            width: 100%;
            height: 12vh;
            background: transparent;

            display: flex;
            align-items: center;
            justify-content: space-evenly;

            input[type=file] {
                display: none;
            }

            button {
                cursor: pointer;
                width: 7vw;
                height: 5vh;
                border-radius: 10px;
                color: white;
                font-family: 'Roboto', sans-serif;
                background: var(--bg-purple);
                font-size: 1.1rem;

            }
        }

        .success {
            cursor: pointer;
            display: flex;
            color: white;
            font-size: 1rem;
            background: #66bb6a;
            font-weight: normal;
            margin: 0 auto 0 auto;
            padding: 0.5rem 1rem;
            border-radius: 10px;
        }
        .rounded {
            width: 100%;
            height: 8vh;
            background: var(--headers);
            border-radius: 1rem;
            padding: 0.5rem 1rem;
            font-family: "Roboto", sans-serif;
            color: rgb(187, 187, 187);

            margin-top: 2vh;

            &:first-child {
                margin-top: 0;
            }

            .line {
                width: 100%;
                height: 1px;
                color: gray;
                margin-top: 1vh;
            }

            .title {
                display: flex;
                height: 6vh;
                .info {
                    height: 100%;
                    display: flex;
                    align-items: center;
                    width: 50%;
                    background: transparent;
                }
                .buttons {
                    width: 78%;
                    height: 6vh;
                    background: transparent;
                    display: flex;
                    align-items: center;
                    justify-content: flex-end;
                    padding-right: 1vh;
                    cursor: pointer;
                    .button {
                        margin-left: 1vw;
                        width: 3rem;
                        height: 3rem;
                        background: var(--bg-purple);
                        border-radius: 0.3rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                        position: relative;

                        .counter {
                            width: 1.1vw;
                            height: 2.1vh;
                            position: absolute;
                            top: 0;
                            transform: translate(1.1vw, -1vh);
                            background: linear-gradient(
                                90deg,
                                #4b6cb7 0%,
                                #32559b 100%
                            );
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            border-radius: 10px;

                            p {
                                font-size: 0.9rem;
                                font-weight: bold;
                            }
                        }
                    }
                }
            }

            .resume {
                width: 100%;
                height: 7vh;
                background: transparent;
                padding: 0.5rem 1rem;

                .profile {
                    margin-top: 1vh;

                    .circle {
                        width: 3rem;
                        height: 3rem;
                        background: transparent;
                        border-radius: 90%;
                        background-image: url("https://m.media-amazon.com/images/M/MV5BNGM0ZGU3MzEtZjMxNS00MDE3LThhMjAtZDRmNTNhYmIzYmNmXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_.jpg");
                        background-repeat: no-repeat;
                        background-size: cover;
                        background-position: center;
                    }
                }

                .bar {
                    margin-top: 1.2vh;
                    width: 100%;
                    height: 5px;
                    background: rgb(145, 144, 144);
                    border-radius: 10px;

                    .progress {
                        width: 0%;
                        height: 100%;
                        background: rgb(61, 102, 212);
                    }
                }

                .data {
                    margin-left: 1vw;
                    margin-top: 0.5vh;
                }
            }
        }
    }
    .container {
        margin-left: 1vw;
        margin-top: 3vh;

        &:first-child {
            margin-left: 0;
        }
    }

    @mixin center() {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .input_type {
        font-family: "Roboto", sans-serif;
        margin-top: 3vh;
        background: var(--bg-body);
        padding: 0.5rem;
        display: flex;
        align-items: center;
        border-radius: 0.7rem;
        height: 5vh;
        position: relative;

        input[type=file] {
            display: none;
        }

        svg {
            position: absolute;
            color: white;
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
            background: var(--headers);
            border-radius: 1rem;
            @include center();
            margin-left: auto;
            border: none;
            transform: translate(0, -0.5vh);
            margin-left: 1vw;

            select {
                font-size: 0.8rem;
                padding: 0 0.5rem;
                background: transparent;
                color: white;
                appearance: none;
                border: 0;
                width: 15rem;
                height: 100%;

                option {
                    color: black;
                }
            }

            .custom-arrow {
                position: absolute;
                background: transparent;
                display: flex;
                width: 5rem;
                height: 100;
                pointer-events: none;

                top: 0;
                right: 0;

                @include center();

                svg {
                    font-size: 1.3rem;
                    color: white;
                }
            }
        }

        .switch {
            display: inline-block;
            height: 2rem;
            position: relative;
            width: 4rem;

            input {
                display: none;
            }

            .slider {
                background-color: #ccc;
                bottom: 0;
                cursor: pointer;
                left: 0;
                position: absolute;
                right: 0;
                top: 0;
                transition: 0.4s;
            }

            .slider:before {
                background-color: #fff;
                bottom: 0.2rem;
                content: "";
                height: 1.6rem;
                left: 0.3rem;
                position: absolute;
                transition: 0.4s;
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
            color: white;
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
                color: white;
            }
        }
    }
}
</style>
