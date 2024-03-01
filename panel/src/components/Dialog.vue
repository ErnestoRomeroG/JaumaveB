<template>
    <div class="dialog">
        <div class="dialogo">
            <div class="title">
                <h2> ¿Estás seguro de hacer esto? </h2>
            </div>

            <div class="desc">
                <slot></slot>
            </div>

            <div class="botones">
                <button @click="$emit('close')">Salir</button>
                <button @click="$emit('onResponse')">Aceptar </button>
            </div>
        </div>  
    </div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>

.dialog {
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

    @keyframes fadeIn {
        
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    .dialogo {
        padding: 0.5rem 1rem 0.5rem 1rem;
        width: 25vw;
        height: 40vh;
        background: var(--headers);
        display: flex;
        flex-direction: column;

        .title {
            background: transparent;
            height: 5.5vh;
            position: relative;
            &::after {
                content: '';
                position: absolute;
                width: calc( 100% - 20%);
                height: 1px;
                bottom: 1px;
                background-color: rgba(26, 26, 26, 0.281);
                
            }
        }
        
        color: white;

        .desc {
            margin-top: 1vh;
        }

        .botones {
            width: 100%;
            height: 7vh;
            margin-top: auto;
            display: flex;
            align-items: center;
            justify-content: space-evenly;

            button {
                width: 5rem;
                height: 70%;
                cursor: pointer;
                color: white;
                border-radius: 0.2rem;
                background: var(--col-green);
                transition: 0.2s transform;
                &:first-child {
                    background: var(--col-red);

                }

                &:hover {
                    transform: scale(1.2);
                }
            }
        }

    }
}
</style>