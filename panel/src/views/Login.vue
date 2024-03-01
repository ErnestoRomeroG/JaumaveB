<template>
    <div class="login">
        
        <main>
            <section>
                <h1 > Bienvenido  </h1>
                <p> Panel administrativo </p>
            </section>
            <section>
                
                <article v-if="currentPage == 0">
                    <h3>Login</h3>
                    <div class="circle">
                    </div>

                    <form @submit.prevent="UserLogin()">
                        <div class="box">
                            <div class="icon">
                                <font-awesome-icon :icon=" ['fas', 'user'] " />
                                <input placeholder="Email" type="text" v-model="login.email" required>
                            </div>
                        </div>

                        <div class="box">
                            <div class="icon">
                                <font-awesome-icon :icon=" ['fas', 'key'] " />
                                <input type="password" placeholder="Contraseña" id="password" v-model="login.pass" required>
                            </div>
                        </div>

                        <p @click="currentPage = 3"> Olvide mi contraseña </p>

                        <div class="botones">
                            <button type="submit">  Ingresar </button>
                        </div>
                        

                    </form>
                </article>
 

                <article v-if="currentPage == 2">
                    <h3>Info</h3>
                    <div class="circle">
                    </div>
                    

                    <form @submit.prevent>
                        <Loading :message_success=" `  ${ message_success }` " /> 
                    </form>

                    
                </article>
 
                
            </section>
        </main>
    </div>
</template>

<script>
import axios from 'axios'
import Loading from '../components/Loading.vue'

export default {
    name: 'Login',
    components: {
        Loading
    },
    data() {
        return {
            currentPage: 0,
            message_success: '',
            login: {
                email: '',
                pass: ''
            },
            registro: {
                nombre: '',
                email: '',
                pass: '',
                conf: ''
            },

            recovery: ''
        }
    },
    methods: {
        userRecovery() {
            if(this.recovery.length == 0) return this.$root.showNotify("error","Ingresa un email valido");

            axios.post("/recovery",  { recovery: this.recovery } ).then(res => {
                if(res.data == "not_found") return  this.$root.showNotify("error","Este email no está asociado a ninguna cuenta");

                if(res.data == "success") {
                    this.currentPage = 2;
                    this.message_success = "Se envió un email con las instrucciones";
                    
                    this.$nextTick(() => {
                        setTimeout(() => {
                            this.currentPage = 0;
                        }, 7000)
                    })
                }
            })
        },
 
        checkCode() {
            if(this.forgetdata.vcode == this.forgetdata.code) {
                this.step = 5;
            }
            else {
                return this.$root.showNotify("error", "Código no valido", 3000);
            }
        },
        UserLogin() {
            
            if(this.login.email.length <= 5)  return this.$root.showNotify("error", "El email debe de tener más de 5 carácteres", 3000);
            if(this.login.pass.length <= 5) return this.$root.showNotify("error", "Ingresa una contraseña valida ");

            axios.post("/api/fund/login", this.login).then(res => {

                if(res.data == "not_found") return this.$root.showNotify("error", "El usuario no ha sido encontrado");
                if(res.data == "mismatch_password") return this.$root.showNotify("error", "Contraseña incorrecta");
                if(res.data == "authorize") return this.$root.showNotify("error", "No estas autorizado");
                
                this.$root.user = res.data;


                //this.$root.auth = res.headers['token'];
                //localStorage.token = res.headers['token'];

                this.$nextTick(() => {

                    //this.step = 3;
                    this.$router.push("/")
                    this.$root.updateLogin()
                })

                
                /*this.message_success = "Se ha iniciado sesión correctamente";
                this.currentPage = 2;
                this.$nextTick(() => {

                    this.step = 3;
                    this.$router.push("/")
                    this.$root.updateLogin()
                })*/
            })
        }
    }
}
</script>

<style lang="scss" scoped>
.login {
    width: 100vw;
    height: 100vh;
    background: #292B2F;
    //background-image: url('../assets/SVG/wave4.svg');
    background-image: url(('../assets/bg.svg'));
    background-size: cover;
    
    background-repeat: no-repeat;
    background-position: -43vw 0;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
    @media screen and (max-width: 768px) {
        
        background-image: none;
        background: var(--main-bg)
    }

    main {
        width: 90vw;
        height: 90vh;
        background: transparent;
        display: flex;

        /* 
            09/23

            006
        */

        section {
            width: 50%;
            height: 100%;
            display: flex;
            
            justify-content: center;

            &:first-child {
                flex-direction: column;
                font-family: 'Lato', sans-serif;
                h1 {
                    
                    font-size: 3rem ;
                    color: white;
                }

                p {
                    color: rgb(202, 202, 202);
                    
                }

                button {
                    margin-top: 2vh;
                    width: 15rem;
                    height: 2rem;
                    background: rgb(255, 71, 71);
                    color: white;
                    cursor: pointer;
                    transition: transform 0.2s ease;
                    &:hover {
                        transform: scale(1.1);
                    }
                }
            }


            &:last-child {
                align-items: center;
            }


            article {
                width: 60%;
                height: 80%;
                background: transparent;
                padding-top: 5vh;

                h3 {
                    text-align: center;
                    font-family: 'Lato', sans-serif;
                    color: white;
                    @media screen and (max-width: 768px) {
                        color: white;
                    }
                }
                
                p {
                    text-align: center;
                    text-decoration: underline;
                    cursor: pointer;
                    color: white;

                    @media screen and (max-width: 768px) {
                        color: white;
                    }
                }

                .circle {
                    width: 5rem;
                    height: 5rem;
                    background: transparent;
                    border-radius: 90%;
                    margin: 4vh auto 0 auto;

                    background-image: url('../assets/user.png');
                    background-position: center;
                    background-size: cover;
                    background-repeat: no-repeat;
                    
                }

                form {
                    margin-top: 2vh;
                    width: 100%;
                    height: 50%;
                    background: transparent;
                    font-family: 'Roboto', sans-serif;
                    padding: 1vh 1rem 0 1rem;


                    .botones {
                        width: 100%;
                        height: 50%;
                        background: transparent;
                        display: flex;
                        flex-direction: column;
                        justify-content: space-evenly;
                        align-items: center;

                        button {
                            cursor: pointer;
                            width: 100%;
                            height: 35%;
                            color: white;
                            background: rgb(68, 209, 167);
                            font-family: 'Lato', sans-serif;
                            font-weight: bold;
                            text-transform: uppercase;
                            

                            &:last-child {
                                background: #6D54DE
                            }
                        }
                        
                    }

                    .box {
                        width: 100%;
                        display: flex;
                        flex-direction: column;
                        height: 20%;

                        label {
                            font-family: 'Lato', sans-serif;
                            font-size: 0.9rem;
                            transform: translate(2.5rem);
                            color: gray;
                            

                            @media screen and (max-width: 768px) {
                                color: white;
                            }
                        }
                        

                        .icon {
                            display: flex;
                            align-items: center;
                            
                            
                            
                            svg {
                                position: absolute;
                                font-size: 1.3rem;
                                transform: translate(0.5rem, 0);
                                color: gray;
                                transition: all 0.2s ease;

                                

                                
                            }

                            input {
                                width: 100%;
                                padding-top: 0.75rem;
                                padding-left: 2.5rem;
                                padding-right: 0.5rem;
                                padding-bottom: 0.75rem;
                                background: transparent;
                                transition: border 0.2s ease;

                                background: #4D5058;
                                color: white;
                                

                                @media screen and (max-width: 768px) {
                                    color: rgb(248, 248, 248);
                                }
                                
                            }

                            
                            &:focus-within {
                                svg {
                                    color: white !important;
                                }

                                input {
                                    border-bottom: 1px solid var(--main-bg);
                                }

                                @media screen and (max-width: 768px) {
                                    svg {
                                        color: white;
                                    }

                                    input {
                                        border-bottom: 1px solid white;
                                    }
                                }
                            }

                            

                            
                        }

                    }
                }

            }

            
        }

        @media screen and (max-width: 768px) {
            height: 100vh;
            padding-top: 10vh;
            flex-direction: column;
            
        
            section {
                
                width: 100%;

                &:first-child {
                    height: 20%;
                    align-items: center;
                    justify-content: center;
                    p {
                        display: none;
                    }
                }

                &:last-child {
                    height: 70%;
                    background: transparent;
                    
                    article {
                        height: 100%;
                        padding: 0;
                        width: 90%;
                    }
                }
            }
            
        }
    }
}
</style>