<template>
    <div class="content">
        <Dialog v-if="inDialog" v-on:onResponse="onResponse" v-on:close="onReject" >
            <p>Estas eliminando una categoria, pulsa  'Aceptar' para eliminarla o 'Salir' para cancelar </p>

            <br>

            <h4> ¿Qué pasará ? </h4>

            <p>Los productos que pertenezcan a esta categoría puede que no sean visibles en la página principal</p>
        </Dialog>

        <div class="cartel">
            <div class="flex">
                <div class="box">
                    <h1> Creador de categorias </h1>

                    <p>
                        Aqui administrarás las categorias, podrás eliminar, crear y editar las mismas.
                        Pero al eliminar una categoría está dejara todos los productos no visibles en la página hasta que lo vuelvas a configurar.
                    </p>
                    
                </div>
                <div class="box">
                    <font-awesome-icon :icon=" ['fas', 'folder-open'] " class="folder" />
                </div>
            </div>

        </div>


        <main>
            <section>
                <div class="container">
                    <div class="box" v-for=" (item, index) in categorias " :key="index">

                        <p> {{index}} </p>

                        <input type="text" ref="categorias" v-model="item.nombre"  :disabled="!(focused == index)" >

                        <div class="icons">
                            <font-awesome-icon :icon=" ['fas', 'pencil'] " @click="edit(index)" />
                            <font-awesome-icon :icon=" ['fas', 'check'] "  @click="save(index)" />
                            <font-awesome-icon :icon=" ['fas', 'times'] "  @click="ShowPlayerDialog(index)" />
                            <font-awesome-icon :icon=" ['fas', 'caret-up'] "  @click="upPosition(index)" />
                            <font-awesome-icon :icon=" ['fas', 'caret-down'] " @click="downPosition(index)" />
                            
                            <font-awesome-icon @click="visibility(item._id)"  :icon=" ['fas',  item.visible ? 'eye' : 'eye-slash' ] " :class="[item.visible ? 'eye' : 'eye-slash' ]" />
                            
                            
                        </div>
                    </div>
                    
                </div>
            </section>
            <section>

                <div class="input_type" style="width: 25%; margin-top: 0;">
                
                    <font-awesome-icon :icon=" ['fas', 'tag'] " /> 
                    <input type="text" v-model="nombre" placeholder="Nombre de la categoria">
                </div>

                <button @click="create()"> Crear </button>
            </section>
        </main>
    </div>
</template>

<script>
import axios from 'axios';
import Dialog from '../components/Dialog.vue'
export default {
    name: 'Categorias',
    components: {
        Dialog
    },
    data() {
        return {
            categorias: [
            ],
            focused: -1,
            nombre: '',
            inDialog: false,
            currentIndexDelete: null,
        }
    },
    methods: {

        create() {
            if(this.nombre.length == 0) return this.$root.showNotify('error', 'Ingresa un nombre valido');
            axios.post('/api/category/create', { nombre: this.nombre }).then(res => {
                if(res.data == "error") return this.$root.showNotify('error', 'La categoría no fue creada');
                if(res.data == "ok") {
                    this.onUpdate();
                    this.nombre = ''
                    this.$root.showNotify('success', 'La categoría fue creada con éxito');
                    
                }
            })
        },
        save(index) {
            this.focused = null
            const data = this.categorias[index]
            axios.post('/api/category/update', { id: data._id , nombre: data.nombre  }).then(res => {
                if(res.data == "error") return this.$root.showNotify('error', 'La categoría no fue creada');
                if(res.data == "ok") {
                    this.onUpdate();
                    this.$root.showNotify('success', 'La categoría fue actualizada con éxito');
                }
            })
        },
        remove(index) {
            axios.post('/api/category/remove', { id: this.categorias[index]._id } ).then(res => {
                if(res.data == "error") return this.$root.showNotify('error', 'La categoría no fue creada');

                if(res.data == "ok") {
                    this.onUpdate();
                    this.$root.showNotify('success', 'La categoría fue borrada con éxito');
                }

            })
        },
        visibility(id) {
            axios.post('/api/category/visibility', { id: id }).then(() => {
                this.onUpdate()
                this.$root.showNotify('success', 'Cambio la visibilidad de la categoria')
            }).catch(() => {
                this.$root.showNotify('error', 'Something wrong...')
            })
        },
        ShowPlayerDialog(playerid) {
            this.currentIndexDelete = playerid;
            this.inDialog = true;
            
        },
        onResponse() {
            this.inDialog = false;
            this.remove(this.currentIndexDelete);
            this.currentIndexDelete = null
        },
        onReject() {
            this.inDialog = false;
            this.currentIndexDelete = null
        },
        upPosition(index) {

            if(index == 0) return false;

            const element =  this.categorias[index];
            this.categorias.splice(index, 1);
            this.categorias.splice(index - 1, 0, element)

        },
        downPosition(index) {
            if(index == this.categorias.length - 1) return false;

            const element =  this.categorias[index];
            this.categorias.splice(index, 1);
            this.categorias.splice(index + 1, 0, element)


        },
        edit(index) {

            this.focused = index;
            //const element = this.$refs[`edit${index}`];
            
            this.$nextTick(() => {
                this.$refs.categorias[index].focus()
            })
        },
        onUpdate() {
            axios.get('/api/category/').then(res => {
                this.categorias = res.data;
                console.log(res.data)
            })
        }
    },
    mounted() {
        
        this.onUpdate();
    }
}
</script>

<style lang="scss" scoped>
@mixin center() {
    display: flex;
    align-items: center;
    justify-content: center;

}



.content {
    width: 100vw;
    height: 91vh;
    background: var(--bg-content);
    
    font-family: 'Manrope', sans-serif;
    user-select: none; 

    

    .cartel {
        width: 98%;
        height: 25vh;
        background: linear-gradient(152deg, rgba(147,87,238,1) 0%, rgba(192,150,255,1) 100%);
        padding: 2vh 0 0 1.5rem ;
        border-radius: 0.3rem;


        .flex {
            width: 100%;
            height: 100%;
            display: flex;
            color: white;
            
            font-family: 'Manrope', sans-serif;
            .box {
                width: 70%;
                height: 100%;
                background: transparent;
                display: flex;
                flex-direction: column;
                padding-bottom: 5vh;

                svg {
                    font-size: 7.5rem;
                    

                    &.folder {
                        color: rgb(240, 201, 72);
                    }


                }

                img {
                    
                    height: 90%;
                    transform: translate(0, 2vh);
                }
                p {
                    margin-top: auto;
                    
                    max-width: 70%;
                    font-size: 1.3rem;
                    
                }

                // 'eye' : 'eye-slash' 

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

    

    main {
        margin-top: 2vh;
        width: 98%;
        height: 69%;
        background: transparent;
        display: flex;

        section {
            width: 90vmin;
            height: 95%;
            

            &:nth-of-type(2) {
                width: 100vmin;
                background: transparent;
                display: flex;
            }

            .container {
                width: 70%;
                display: flex;
                flex-direction: column;
                margin: 0 auto 0 auto;
                color: var(--bg-gray);
                .box {
                    padding-left: 1rem;
                    width: 100%;
                    height: 6vh;
                    background: var(--bg-body);
                    display: flex;
                    align-items: center;
                    border-radius: 0.2rem;
                    font-family: 'Manrope', sans-serif;
                    

                    input {
                        margin-left: 2vw;
                        width: 50%;
                        font-size: 1.0154rem,;
                        padding: 0.5vh 0.3vw;
                        background: transparent;
                        border-bottom: 0.1px solid rgba(0, 0, 0, 0.349);
                        color: var(--bg-gray);
                        &:disabled {
                            border: none;
                        }
                    }

                    .eye {
                        color: #66bb6a ;
                        
                    }

                    .eye-slash {
                        color: red;
                        
                    }

                    .icons {
                        width: 35%;
                        height: 100%;
                        @include center();
                        justify-content: space-evenly;
                        background: transparent;

                        svg {
                            font-size: 1.5rem;

                            @media screen and (max-width: 1500px) {
                                font-size: 1rem;
                            }
                            cursor: pointer;

                            &:nth-of-type(1) {
                                color: var(--col-blue);
                            }
                            &:nth-of-type(2) {
                                color: var(--col-green);
                            }
                            &:nth-of-type(3) {
                                color: var(--col-red);
                            }

                            
                        }


                        
                        
                    }

                    &:first-child {
                        
                        
                        .icons {
                            svg {
                                &:nth-of-type(4) {
                                    color: rgb(170, 170, 170);
                                    
                                }

                                &:nth-of-type(5) {
                                    color: black !important;
                                }

                            }
                        }
                        
                    }

                    &:last-child {
                        
                        
                        .icons {
                            svg {
                                &:nth-of-type(5) {
                                    color: rgb(170, 170, 170);
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            button {
                margin-top: 1vh;
                margin-left: 1vw;
                width: 5rem;
                height: 5vh;
                background: var(--col-green);
                border-radius: 0.2rem;
                color: white;
                cursor: pointer;
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
                    color: white;
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

        }


    }

    
}
</style>