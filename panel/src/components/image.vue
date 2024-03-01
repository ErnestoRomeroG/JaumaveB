<template>
    <div class="image">
        <div class="showimage " :class=" [desactive ? 'desactive' : ''] "   id="showimage" >
            <img  :src="url" loading="lazy">
        </div>
    </div>
</template>

<script>
//@max306ljs#6537 

export default {
    name: 'Imagen',
    props: {
        url: String
    },
    data() {
        return {
            desactive: false
        }
    },
    methods: {
        async detectClick(evt) {           
            if(this.desactive) return;
            const flyoutElement = document.getElementById("showimage");
            let targetElement = evt.target; // clicked element

            do {
                if (targetElement == flyoutElement) {
                    // This is a click inside. Do nothing, just return.
                    console.log('INSIDE CLICK')
                    return;
                }
                // Go up the DOM
                targetElement = targetElement.parentNode;
            } while (targetElement);
            
            // This is a click outside.
            /*this.inDialog = false;
            this.detect = false;*/
            this.desactive = true;
            await this.sleep(100);
            this.$emit('close');

        },
        sleep(ms) {
            return new Promise((resolve) => {
                setTimeout(() => {
                    resolve()
                }, ms)
            })
        }
    },
    async beforeMount( ) {
        
        document.addEventListener("click", this.detectClick)
    }
}
</script>

<style lang="scss" scoped>
.image {
    width: 100vw;
    height: 100vh;
    background: transparent;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    animation: fadeIn 0.5s ease;

    .showimage{ 
        background: rgb(0, 0, 0);
        max-width: 50vw;
        height: 90vh;
        display: flex;
        align-items: center;
        justify-content: center;
        img {

            transform: scale(1);
            max-height: 80vh;
            
            animation: 0.2s bounce;    
            user-select: none;


            
        }

        &.desactive {
            transform: scale(0) !important;
            animation: 0.2s unbounce;
        }
    }

    @keyframes bounce {
        from {
            transform: scale(0);
        }
        to {
            transform: scale(1);
        }
    }

    @keyframes unbounce {
        from {
            transform: scale(1) ; 
        }
        to {
            transform: scale(0);
        }
    }
}
</style>