<template>
    <div class="loading">
        <h3 v-if="progress < 100 && !canceled">Los archivos se estan subiendo, por favor espere.</h3>
        <h3 v-if="progress >= 100 && !canceled">  Los archivos se han subido con éxito  </h3>

        <h3 v-if="canceled"> Se ha cancelado la carga por el usuario </h3>
        <div class="loader">
            <div class="loading-circle" v-bind:style="getProgress">
                <p class="loading-count"><span id="loadingNumber"> {{progress}} </span>%</p>
            </div>
        </div>

        <div class="button">

            <button v-if="progress >= 100 || canceled" @click="$router.push('/producto')"> Salir </button>
            <button v-else @click="cancel()" class="red"> Cancelar carga </button>
        </div>
        
    </div>
</template>

<script>
export default {
    name: "Uploader",
    props: {
        progress: {
            type: Number,
            default: 0
        }
    },
    data() {
        return {
            canceled: false
        }
    },
    methods: {
        cancel() {

            this.canceled = true;
            this.$emit('cancel');
        }
    },
    computed: {
        getProgress() {
            return { background: `conic-gradient(from 0deg at 50% 50%, rgba(116, 18, 228, 1) 0%, rgba(191, 155, 248, 1) ${this.progress}%, #101012 ${this.progress}%)` }
        }
    }
};
</script>

<style lang="scss" scoped>

.loading {
    width: 100vw;
    height: 92vh;
    position: fixed;
    background: rgba(20, 20, 31, 0.966);
    z-index: 1;
    top: 9vh;
    left: 5vw;
    padding-top: 7vh;
    color: white;
    

    h3 {
        text-align: center;
    }


    .button {
        margin-top: 5vh;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;

        button {

            padding: 1rem 3rem;
            border-radius: 0.5rem;
            background: var(--col-green);
            color: white;
            cursor: pointer;
        }

        .red {
            background: var(--col-red);
        }
    }
    

    .loader {
        align-items: center;
        display: flex;
        justify-content: center;
        margin-top: 7vh;
        align-items: center;

        .mid {
            position: absolute;
 
        }

        p {
            position: absolute;
            font-size: 1rem;
        }

        .loading-box {
            position: relative;
            width: 300px;
            height: 400px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: #f0f8ff;
            border-radius: 12px;
            box-shadow: 4px 4px 16px rgba(0, 0, 0, 0.5),
                -4px -4px 16px rgba(255, 255, 255, 0.05);
        }


        .loading-circle {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 180px;
            height: 180px;
            background: conic-gradient(
                from 0deg at 50% 50%,
                rgba(116, 18, 228, 1) 0%, rgba(191, 155, 248, 1) 0%,
                #101012 0%
            );
            border-radius: 100px;
            box-shadow: 4px 4px 16px rgba(0, 0, 0, 0.75),
                -4px -4px 16px rgba(255, 255, 255, 0.1);
            animation: spin 1s infinite linear;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        .loading-count {
            content: " ";
            display: flex;
            justify-content: center;
            align-items: center;
            top: 3px;
            left: 3px;
            width: 174px;
            height: 174px;
            border-radius: 100px;
            background: #161331;
            box-shadow: 4px 4px 16px rgba(0, 0, 0, 0.75) inset,
                -4px -4px 16px rgba(255, 255, 255, 0.1) inset;
            animation: spin 1s infinite linear reverse;
        }

        .loading-count #loadingNumber {
            font-size: 4em;
        }
    }
}
</style>
