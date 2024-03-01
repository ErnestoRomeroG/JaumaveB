<template>
    <div class="ticket">

        <Image  v-if="viewImage" v-bind:url="currentImageURL" v-on:close=" closeImage() " />
        <div class="chat">
            
            <div class="title">
                <font-awesome-icon class="close" :icon="['fas', 'times-circle']"  @click="$emit('close') "/>
                <div class="user">
                    <div class="circle"  :style=" [{ 'background-image': `url(${image}) `}] " ></div>
                    <p> Jasso </p>
                </div>

                <div class="header">
                    <h3>
                        {{ticket.title}}
                    </h3>
                </div>

            </div>

            <div class="messages" id="messages">
                <div v-for=" (item, index) in ticket.messages " :key="index">
                    <article :class=" [item.fromUser ? 'out' : ''] ">
                        <div class="box">
                            <p> {{item.texto}} </p>

                            <img v-if="item.image !== '' " @click="  setImageView(item.image)"  :src=" getImage(item.image) " alt="" loading="lazy">
                            

                        </div>
                        
                    </article>
                    
                </div>
            </div>

            <form @submit.prevent="pushMessage()">
                <div class="botones">          
                    <div class="svg">
                        <font-awesome-icon :icon="['fas', 'image']" :class=" [ file ? 'active' : '' ] "  type="button" @click=" focusFile()  " />
                        <input type="file" @change="onImageUpload" id="file" style="display: none;" accept="image/*">
                    </div>

                    <div class="input">
                        <input type="text" v-model="msg" placeholder="Ingresar mensaje" required />
                        <button style="background: transparent;">
                            <font-awesome-icon :icon="['fas', 'paper-plane']" />
                        </button>
                        
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import Image from './image.vue'
export default {
    name: 'Ticket', 
    components : {
        Image
    },
    props: {
        ticketId: String
    },
    data() {
        return {
            ticket: {
                userID: '',
                date: 0,
                title: '',
                messages: [
                    {
                        id: "ux234-12-34asd-ddwasdw222",
                        fromUser: true,
                        texto: 'Hola, quiero donar latas de comida',
                        image: '',
                    }
                ],
                status: ''
            },
            newMessages: [],
            image: '',
            timer: null,
            msg: '',
            file: undefined,
            viewImage: false,
            currentImageURL: '',
            userName: ''
        }
    },
    methods: {
        closeImage() {
            this.viewImage = false 
        },
        focusFile() {
            document.getElementById('file').click()
        },
        getImage(id) {
            return axios.defaults.baseURL+ '/api/ticket/image/'+id ;
        },
        sleep(ms) {
            return new Promise((resolve) => {
                setTimeout(() => {
                    resolve()
                }, ms)
            })
        },
        async setImageView(id) {
            
            this.currentImageURL = axios.defaults.baseURL+ '/api/ticket/image/'+id ;

            await this.sleep(100);
            this.viewImage = true;
        },
        onImageUpload: function(e) {
            const file = e.target.files[0];
            this.file = file;
        },
        isEqualArray(arr1, arr2) {
            if (arr1.length !== arr2.length) return false;
            for (var i = 0; i < arr1.length; i++) {
                if (arr1[i].id !== arr2[i].id) return false;
            }
            return true;
        },
        pushMessage() {
            

            const data = {
                ticketId: this.ticket._id,
                fromUser: false,
                message: this.msg
            }

            const fd = new FormData(); 

            fd.append("data", JSON.stringify(data));
            fd.append('imagen', this.file);

            axios.post('/api/ticket/message',  fd ).then(res => {
                if(res.status == 200) {
                    this.msg = '';
                    return;
                }
            })
            
        },
        updateMessages() {
            axios.get(`/api/ticket/${this.ticketId}`).then(async (res) => {
                if(!this.isEqualArray(this.ticket.messages, res.data.tickets.messages )) {
                    this.ticket.messages = res.data.tickets.messages
                    this.$nextTick(() => {
                        const objDiv = document.getElementById("messages");
                        objDiv.scrollTop = objDiv.scrollHeight;
                    })
                }
            }).catch((error) => {
                this.$root.showNotify('error', this.$t(error.response.data))
            })
        }
    },
    async beforeMount() {

        
        
        axios.get(`/api/ticket/${this.ticketId}`).then(async (res) => {

            this.ticket = res.data.tickets;

            this.$nextTick(() => {
                const scrollDiv = document.getElementById("messages");
                scrollDiv.scrollTo({ top: scrollDiv.scrollHeight, behavior: 'smooth'});
            })

            axios.get(`/api/auth/profile/image/${res.data.user._id}`, {  responseType: 'arraybuffer' } ).then(res => {
                const arrayBufferView = new Uint8Array( res.data );
                const blob = new Blob( [ arrayBufferView ], { type: "image/jpeg" } );
                this.image = URL.createObjectURL(blob);
            })
        }).catch((error) => {
            this.$root.showNotify('error', this.$t(error.response.data))
        })
    },
    async mounted() {
        this.$nextTick(() => {
            this.timer = setInterval(() => {
                //this.updateMessages();
            }, 500)
        })
    },
    beforeUnmount() {
        if(this.time !== null) clearInterval(this.timer);
    }
};
</script>

<style lang="scss" scoped>
.ticket {
    width: 100vw;
    height: 100vh;
    background: rgba(41, 41, 41, 0.356);
    
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    animation: fadeIn 0.5s ease;

    font-family: 'Manrope', sans-serif;

    

    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    .chat {
        
        position: relative;
        width: 25vw;
        height: 55vh;
        background: var(--headers);
        display: flex;
        flex-direction: column;
        border-radius: 1rem;

        .title {
            background: var(--headers);
            height: 9vh;
            position: relative;
            display: flex;
            padding-left: 1rem;
            padding: 0.5rem 2rem 1rem ;
            padding-bottom: 2rem;
            border-radius: 1rem 1rem 0rem 0;
            color: black;

            svg {
                color: rgb(255, 74, 74);
                font-size: 1.1rem;
            }

            .close {
                position: absolute;
                right: 1rem;
                cursor: pointer;
            }
            .user {
                display: flex;
                height: 8vh;
                width: 10ch;
                background: transparent;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                color: white;
            }
            .circle {
                width: 3rem;
                height: 3rem;
                background: rgb(216, 216, 216);
                border-radius: 90%;
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
            }

            .header {
                width: 80%;
                height: 100%;
                background: transparent;
                display: flex;
                align-items: center;
                justify-content: center;
                
                p {
                    max-width: 15ch;
                }
            }
        }

        

        .desc {
            margin-top: 1vh;
        }

        .messages {
            width: 100%;
            height: 70%;
            background: var(--bg-body);
            
            padding: 1vh 1vw 0 1vw;
            overflow: auto;
            scroll-behavior: smooth;

            &::-webkit-scrollbar-track {
                -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
                box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
                background-color: transparent;
            }
            &::-webkit-scrollbar {
                width: 0.2vw;
                background-color: transparent;
            }
            &::-webkit-scrollbar-thumb {
                background-color: #ffffff;
            }

            article {
                
                display: flex;
                width: 100%;
                justify-content: flex-end;

                &.out {
                    justify-content: flex-start;
                    .box {
                        background: rgb(48, 48, 48);
                    }
                }
                .box {
                    &:first-child {
                        margin-top: 0;
                    }

                    margin-bottom: 0.5vh;
                    max-width: 80%;
                    height: auto;
                    color: white;
                    
                    font-size: 0.8rem;
                    background: rgb(38, 96, 221);
                    padding: 0.5rem 1rem 0.5rem 1rem;
                    word-break: keep-all;
                    border-radius: 1rem;

                    img {
                        margin-top: 1vh;
                        width: 10rem;
                        cursor: pointer;
                    }
                }
            }
        }

        .botones {
            width: 100%;
            height: 4vh;
            margin-top: 2vh;
            display: flex;
            justify-content: center;
            align-items: center;
            

            .svg {
                background: transparent;
                font-size: 1.3rem;
                cursor: pointer;
                color: white;
                .active {
                    color: var(--col-green);
                }
            }

            
            .input {
                
                height: 100%;
                width: 80%;
                border: 1px solid var(--bg-gray);
                background: transparent;
                border-radius: 1rem;
                margin-left: 2ch;
                padding: 0.3rem 1rem;
                
                background: var(--bg-body);

                input {
                    height: 100%;
                    width: 84%;
                    background: transparent;
                    color: white;
                    &::placeholder {
                        color: var(--bg-gray);
                    }
                }

                svg {
                    background: transparent;
                    margin-left: 1vw;
                    color: var(--bg-gray);
                    cursor: pointer;
                }
            }
        }
    }
}
</style>
