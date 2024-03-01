<template>
    <div class="content">

        <Inbox v-if="viewInbox" v-on:close="viewInbox = false" />
        <div class="cartel">
            <div class="flex">
                <div class="box">
                    <h1>Mensajeria</h1>

                    <p>
                        Bienvenido al imbox. <br />
                        En este espacio podrás mirar los mensajes de las
                        personas que están en contacto para realizar una
                        donación
                    </p>
                </div>
            </div>
        </div>
        <div class="contenido">
            <Model
                v-bind:title="'Filtros'"
                class="table"
                style="width: 25vw; height: 50vh"
            >
                <div class="filters">
                    <div class="fil">
                        <font-awesome-icon :icon="['fas', 'times']" />
                        <p>Todos</p>
                    </div>
                </div>
                <div class="line"></div>

                <div class="users">
                    <h3>Usuario</h3>

                    <div class="search">
                        <font-awesome-icon :icon="['fas', 'search']" />
                        <input type="text" placeholder="Busqueda de usuario" />
                    </div>
                </div>
                <div class="line"></div>
                <div class="users">
                    <h3> Estado </h3>

                    <div class="checks">

                        <div class="box">
                            <input type="checkbox" name="proceso">
                            <label for="proceso">En proceso</label>
                        </div>

                        <div class="box">
                            <input type="checkbox" name="proceso">
                            <label for="proceso">Completo </label>
                        </div>

                        <div class="box">
                            <input type="checkbox" name="proceso">
                            <label for="proceso">Incompleto</label>
                        </div>
                    </div>
                </div>

                <div class="line"></div>
                <div class="users"></div>
                <div class="users">
                    <h3> Prioridad </h3>

                    <div class="box">
                        <input type="range"  min="0" max="100">
                    </div>
                </div>
            </Model>

            <div class="cards">
                
                <div class="rounded">
                    <div class="title">
                        <div class="info">
                            <p> Total de mensajes 1 </p>
                            <h3> Donación de alimentos prueba </h3>
                        </div>
                        <div class="buttons">
                            <div class="button" @click="viewInbox = true">
                                <div class="counter">
                                    <p>1</p>
                                </div>
                                <font-awesome-icon :icon="['fas', 'envelope']" />
                            </div>

                            <div class="button">
                                <font-awesome-icon :icon="['fas', 'user']" />
                            </div>

                            <div class="button">
                                <font-awesome-icon :icon="['fas', 'check']" />
                            </div>

                            <div class="button">
                                <font-awesome-icon :icon="['fas', 'times']" />
                            </div>
                        </div>
                    </div>
                    <div class="line"></div>
                    <div class="resume">
                        <div class="profile">
                            <div class="circle"></div>
                        </div>

                        <div class="data">
                            <h3> Jasso </h3>
                            <p> Hola, quiero donar latas de comida </p>
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
import Inbox from '../components/Ticket.vue'
export default {
    name: "Home",
    components: {
        Model,
        Advice,
        Inbox
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
            viewInbox: false
        };
    },
    methods: {},
    mounted() {},
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
        display: flex;
        flex-wrap: wrap;
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

            .search {
                width: 60%;
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

                input {
                    background: transparent;
                    height: 100%;
                    width: 100%;
                    padding-left: 1.5rem;

                    &::placeholder {
                        color: var(--bg-gray);
                    }
                }
            }

            input[type=range] {
                width: 95%;
                background-color: red;
                
            }
            
            .checks {
                margin-top: 1vh;
                font-family: 'Roboto', sans-serif;
                display: flex;
                label {
                    font-size: 0.9rem;
                    margin-left: 10px;
                    color: gray;
                }

                input[type=checkbox] {
                    
                    accent-color: var(--bg-purple);
                }
            }
        }

        .rounded {
            width: 100%;
            height: 15vh;
            background: var(--headers);
            border-radius: 1rem;
            padding: 0.5rem 1rem;
            font-family: 'Roboto', sans-serif;
            color: rgb(187, 187, 187);
            
            .line {
                width: 100%;
                height: 1px;
                color: gray;
                margin-top: 1vh;
            }

            .title {
                display: flex;

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
                    

                }

                
            }

            .resume {
                width: 100%;
                height: 7vh;
                background: transparent;
                display: flex;
                padding: 0 1rem;

                
                .profile {
                    margin-top: 1vh;

                    .circle {
                        width: 3rem;
                        height: 3rem;
                        background: transparent;
                        border-radius: 90%;
                        background-image: url('https://m.media-amazon.com/images/M/MV5BNGM0ZGU3MzEtZjMxNS00MDE3LThhMjAtZDRmNTNhYmIzYmNmXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_.jpg');
                        background-repeat: no-repeat;
                        background-size: cover;
                        background-position: center;
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
}
</style>
