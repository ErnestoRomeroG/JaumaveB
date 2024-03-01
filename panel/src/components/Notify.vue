<template>
    <div v-bind:class=" [ type , 'notify'] ">
        <div class='icono' >

        </div>
        <div class="text">
            <div class="titulo">
                <h4>Información</h4>
            </div>
            <div class="desc">
                <p>{{message}}</p>
            </div>
        </div>
    </div>
</template>

<script>
 
export default {
    name: 'notify',
    props: {
        type: String,
        message: String
    },
    components: {

    },
    data() {
        return {
            icons: {
                'info': 'info-circle',
                'success': 'check-circle',
                'error': 'times-circle',
                'warning': 'exclamation-circle',
            }
        }
    },
    methods: {
        getIcon(type) {
            return this.icons[type];
        }
    }
}
</script>

<style lang="scss" scoped>

    .success {
        background: rgb(92, 177, 92) !important;
        color: white;
    }

    .warn {
        background: rgb(223, 193, 62);
        color: white;
    }

    .error {
        background: rgb(235, 56, 56);
        color: white;
    }

    .info {
        background: rgb(56, 154, 235) !important;
        color: white;
    }   

.notify {
    
    position: fixed;
    width: 20vw;
    height: auto;

    @media screen and (max-width: 768px) {
        width: 70vw;
    }

    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    
    padding-bottom: 2vh;
    
    z-index: 2;
    top: 15%;
    right: 2%;
    display: flex;
    -webkit-box-shadow: 0px 0px 3px 0px rgba(0,0,0,0.75);
    -moz-box-shadow: 0px 0px 3px 0px rgba(0,0,0,0.75);
    box-shadow: 0px 0px 3px 0px rgba(0, 0, 0, 0.397);
    color: white;
    .icono {
        width: 15%;
        margin-top: auto;
        margin-bottom: auto;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .text {
        width: 80%;
        height: auto;
        
        .titulo {
            width: 100%;
            height: 5vh;
            background: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .desc {
            width: 100%;
            height: auto;
            max-height: 100%;
            
            
            font-size: 0.93rem;
            background: transparent;
            padding-left: 0.2vw;
        }
    }
}


</style>