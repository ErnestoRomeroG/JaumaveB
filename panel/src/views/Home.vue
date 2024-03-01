<template>
    <div class="content">
        <div class="cartel">
            <div class="flex">
                <div class="box">
                    <h1>Bienvenido</h1>

                    <p>
                        Bienvenido al panel de control de fundaciones. <br>  En este espacio podrás administrar, crear, eliminar publicaciones de peticiones. También podrás comunicarte con los usuarios que quieran apoyar.
                    </p>
                </div>
                
            </div>
        </div>
        <div class="contenido">
            <!--
            <Model v-bind:title="'Peticiones'" class="table" style="width: 18vw; height: 50vh">
                <div class="box" v-for=" (item)  in posts " :key="item._id">
                    <p> {{item.titulo}} </p>
                    <div class="bar">
                        <div class="progress"></div>
                    </div>
                </div>
            </Model>

            <Model v-bind:title="'Top de usuarios'" class="table" style="width: 18vw; height: 50vh" >
                <div class="box">
                    
                </div>
            </Model> -->
            <div class="cards">
                <Advice color="#26de5a" title="Hospedaje" :info="peticiones_totales" :desc=" 'Mostradas actualmente' " >
                    <font-awesome-icon :icon="['fas', 'hotel']" style="color: #30A691; " />
                </Advice>

                <Advice color="#26de5a" title="Gastronomia" :info="success" :desc=" 'Mostradas actualmente' " >
                    <font-awesome-icon :icon="['fas', 'hamburger']" style="color: #e2a32e;" />
                </Advice>

                <Advice color="#26de5a" title="Biodiversidad" :info="donaciones" :desc=" 'Mostradas actualmente' " >
                    <font-awesome-icon :icon="['fas', 'people-robbery']" style="color: #cee40b" />
                </Advice>
                
                <Advice color="#26de5a" title="Artesanos" :info="donaciones" :desc=" 'Mostradas actualmente' ">
                    <font-awesome-icon :icon="['fas', 'palette']" style="color: #E4740B" />
                </Advice>

                <Advice color="#26de5a" title="Emblematicos" :info="success" :desc=" 'Mostradas actualmente' " >
                    <font-awesome-icon :icon="['fas', 'flag']" style="color: #28C04A;" />
                </Advice>

                <Advice color="#26de5a" title="Eventos" :info="donaciones" :desc=" 'Mostradas actualmente' " >
                    <font-awesome-icon :icon="['fas', 'calendar-days']" style="color: #0b50e4" />
                </Advice>

                <Advice color="#26de5a" title="Donaciones" :info="donaciones" :desc=" 'Mostradas actualmente' " >
                    <font-awesome-icon :icon="['fas', 'heart']" style="color: #E4740B" />
                </Advice>
                



                
                
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
export default {
    name: "Home",
    components: {
        Model,
        Advice,
    },
    data() {
        return {
            userCount: 0,
            totalIncrease: 0,
            totalBuys: 0,
            tickets: 0,
            last: [],
            bestVideos: [],
            user: [],
            peticiones_totales: 0,
            success: 0,
            posts: [],
            donaciones: 0
        };
    },
    methods: {},
    mounted() {
        /*
        axios.get("/api/publicaciones").then((res) => {
            
            this.peticiones_totales = res.data.length
        })

        axios.get("/api/donacion").then((res) => {
            
            this.donaciones = res.data.length
        })*/
        /*axios.get("/api/admin/peticiones/").then((res) => {

            this.peticiones_totales = res.data.all
            this.success = res.data.success
        });

        axios.get("/api/fund/").then((res) => {

            this.posts = res.data;
        })*/
        
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

    .cards {
        display: grid;
        grid-template-columns: repeat(4,  1fr);
        grid-row-gap: 2vh;
        padding: 3vh;
        background: transparent;
        width: 80%;

        .card {
            margin-left: 2vw;
            margin: 0;
            &:first-child, &:nth-child(3) {
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
            font-family: "Segoe UI", "Roboto", "Helvetica Neue", Arial, sans-serif;
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
        .top {
            width: 100%;
            height: 70%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .table {
            background: var(--headers);
            color: white;
            font-family: 'Roboto';
            .box {
                margin-top: 1vh;
                p {
                    color: rgb(156, 156, 156);
                }

                .bar {
                    margin-top: 5px;
                    width: 90%;
                    height: 1vh;
                    background: gray;
                    border-radius: 10px;

                    .progress {
                        width: 50%;
                        height: 1vh;
                        background: rgb(61, 102, 212);
                    }
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
}
</style>
