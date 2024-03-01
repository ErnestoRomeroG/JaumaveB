<template>
    <div class="content">

        <h3> Seleccione un tipo de archivo a crear </h3>
        <div class="box" @click="selectedData(1)">
            <div class="icon">
                <font-awesome-icon :icon=" ['fas', 'photo-video'] " />

                
            </div>

            <p> 
                Con está opción crearas un contenido de video para la plataforma.
                Podrás editar los tiempos de renta, costo, visibilidad, descripción y cover de photo
            </p>


        </div>
        

        <div class="box" @click="selectedData(2)">
            <div class="icon">
                <font-awesome-icon :icon=" ['fas', 'file-alt'] " />
            </div>

            <p> 
                Con está opción crearas un contenido leible para la plataforma.
                Se requiere tener el archivo en PDF.
                Podrás editar las mismas cosas que la anterior opción

            </p>

        </div>

    </div>
</template>

<script>
export default {
    name: 'Main Selector',
    methods: {
        selectedData(type) {
            // 1 media 
            // 2 doc
            this.$emit('selected', type)

        }
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
    width: 80vw;
    height: 70vh;
    background: #EFEFEF;
    font-family: 'Manrope', sans-serif ;
    user-select: none; 

    @include center();
    justify-content: space-evenly;

    h3 {
        position: absolute;
        top: 15vh;
    }
    .box {
        height: 40vh;
        width: 25vw;

        border: 1px solid gray;
        padding-top: 3vh;
        padding: 3vh 1.5rem 3vh 1.5rem;
        border-radius: 0.7rem;
        cursor: pointer;
        transition: 
            transform 0.2s
        ;

        &:nth-of-type(1) {
            background: var(--col-red);
        }

        &:nth-of-type(2) {
            background: var(--col-blue);
        }

        color: white;
        .icon {
            width: 100%;
            height: auto;
            display: flex;
            svg {
                margin: 0 auto 0 auto;
                font-size: 4rem;
                color: white;
            }
        }

        p {
            margin-top: 3vh;
            max-width: 80%;
            display: flex;
            
        }

        display: flex;
        flex-direction: column;

        &:hover {
            transform: scale(1.1);
        }

        button {
            margin-top: auto;
            width: 100%;
            background: var(--col-green);
            height: 5vh;
            color: white;   
            transition: transform 0.2s;
            cursor: pointer;

            &:hover {
                transform: scale(1.05);
            }
        }

        
    }
}
</style>