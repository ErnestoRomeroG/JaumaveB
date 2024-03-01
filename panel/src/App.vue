<template>
    <div>
        
        <div class="cell_phone_warning">
            <h1> El panel solo es accesible desde un ordenador </h1>
        </div>
        <Navbar v-if="!Login"/>
        <transition name="fade">  
            <Notify  v-if="notify" v-bind:type="type"  v-bind:message="message" />
        </transition>
        <Header v-if="!Login"/>
        <router-view class="body"/>


    </div>

</template>

<script>
import Navbar from './components/Navbar.vue';
import Header from './components/Header.vue';
import Notify from './components/Notify.vue';
import axios from 'axios';

//axios.defaults.baseURL = "https://api.nethzel.com:8463"
axios.defaults.baseURL = "http://localhost:3000"
axios.defaults.withCredentials = true;

export default {
    name: 'App',
    components: {
        Navbar,
        Header,
        Notify
    },
    data() {
        return {
            notify: false,
            type: 'info',
            message: '',
            timeout: undefined,
            Login: false,
            user: null,
            logged: false,
            planEdit: '',
            profile: null
        }
    },
    methods: { 
        showNotify(type, message, time = 3000)  {

            if(this.timeout !== undefined) clearTimeout(this.timeout)
            this.type = type;
            this.message = message;
            this.notify = true;
            this.timeout = setTimeout(() => {
                this.notify = false;
            }, time)
        },
        updateLogin() {


            /*axios.get("/api/fund/" ).then(res => {
                this.user = res.data;
                this.logged = true;
            }).catch(() => {

                this.logged = false;
                this.$router.push('/login');
            })*/
        },
        logout() {
            /*axios.get("/api/auth/logout" ).then((res) => {
                if(res.data == "logout") {
                    
                    this.$nextTick(() => {
                        this.updateLogin();
                        this.$router.push('/')
                    })
                }
            })*/
        }
    },
    watch: {
        '$route.path' () {
 
            this.$route.path !== '/' ? this.black = true : this.black = false;

            this.Login = this.$route.path === '/login'
            this.updateLogin();
        }
    },
    
    beforeMounte() { 
        this.updateLogin();
    }
}
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Roboto+Condensed&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Inter&family=Manrope&display=swap');
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Thai+Looped&display=swap');
//font-family: 'IBM Plex Sans Thai Looped', sans-serif;

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    --bg-body: #292b2f;
    --headers: #25262b;
    --navbar: #232429;
    --bg-gray: #adadad;
    --bg-purple: #9357ee;
    --low-purple: #a172e7;
    --bg-content: #1f2124;
    --col-green: #00B247;
    --col-red: #E0371F;
    --low-red: #da5341;
    --col-blue: #1f62e0;
    --col-nethzel: #6CC9B7;

    &::-webkit-scrollbar-track
    {
        
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        background-color: transparent;
    }

    &::-webkit-scrollbar
    {
        width: 0.4vw;
        background-color: transparent;
    }

    &::-webkit-scrollbar-thumb
    {
        
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        background: linear-gradient(100deg, rgba(154,71,255,1) 0%, rgba(64,0,255,1) 100%);
    }
}

select, button, input, textarea {
    border: none;

    &:focus {
        outline: none;
    }
}


.body {
    padding-left: 6.5vw;
    padding-top: 10vh;
}

body {
    width: 100vw;
    height: 100vh;
    background: var(--bg-content);
    
    

    overflow-x: hidden;
}

.cell_phone_warning {
    display: none;
    pointer-events: none;
    position: absolute;
    z-index: 4;
    width: 100vw;
    height: 101vh;
    background-color: var(--bg-purple);
    top: 0;
    left: 0;
    padding: 0 1rem;

    @media screen and (max-width: 768px) {
        display: flex;
        pointer-events: all;
        align-items: center;
        justify-content: center;
        text-align: center;
        font-family: 'Manrope';
        color: white;

    }

}

.fade-enter-active {
        animation: fade-in .2s;
}
.fade-leave-active {
    animation: fade-in .2s reverse;
}

@keyframes fade-in {
    0% {
        opacity: 0;
    }
    25% {
        opacity: 0.25;
    }
    50% {
        opacity: 0.5;
    }
    75% {
        opacity: 0.75;
    }
    100% {
        opacity: 1;
    }
}

</style>
