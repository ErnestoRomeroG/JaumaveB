<template>
    <div class="header">
        <h2>Gobierno Municipal de Jaumave {{ currentNav }} </h2>


        
        <!--<div class="nav">
            
            <div class="search">
                <font-awesome-icon :icon=" ['fas', 'search'] " />
                <input type="text" placeholder="Busqueda de usuario">
            </div>

            <div class="bell">
                <div class="circulo">
                    <font-awesome-icon :icon=" ['far', 'envelope'] " />
                    
                </div>
                <p>01</p>
            </div>

            <div class="bell">
                <div class="circulo">
                    <font-awesome-icon :icon=" ['far', 'bell'] " />
                    
                </div>
                <p>01</p>
            </div>
            

        <div class="user"  :style=" [{ 'background-image': `url(${$root.profile}) `   }] ">
                
        </div>

        </div>-->
    </div>
</template>

<script>

//console.log(this.$route)
export default {
    name: 'Header',
    data() {
        return {
            currentNav: ''
        }
    },
    watch: {
        "$route.path"() {
            
            let data = this.$route.path;
            if(this.$route.params) {

                if(this.$route.params.id) { 
                    data = data.replace(`/${this.$route.params.id}`, "")
                }


                data = `> ${data.slice(1).replace('/', ' > ')}`
                this.currentNav = data;
                return;

            }

            this.currentNav  = this.$route.path !== '/' ? `> ${this.$route.path.slice(1).replace('/', ' > ')}` : ''
            
            //this.currentNav = ""


        }
    },
    mounted() {
        
        
    }
}
</script>

<style lang="scss" scoped>

@mixin center() {
    display: flex;
    justify-content: center;
    align-items: center;
}

.header {
    position: fixed;
    padding-left: 6.5vw;
    z-index: 2;
    width: 100vw;
    height: 9vh;
    background: var(--headers);
    display: flex;
    align-items: center;

    h1,h2, h3 {
        font-family: "Segoe UI",'Roboto',"Helvetica Neue",Arial,sans-serif;
        text-transform: capitalize;
        color: rgb(206, 206, 206);
    }

    .nav {
        width: 30%;
        height: 100%;
        background: transparent;
        margin-left: auto;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        padding-right: 2.5vw;
        .search {
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

        .bell {
            margin-left: 1vw;

            width: 12%;
            height: 60%;
            background: transparent;
            transition: all 0.2s ease;
            @include center();
            justify-content: flex-start;
            position: relative;

            .circulo {
                @include center();
                height: 100%;
                width: 100%;
                background: var(--bg-body);
                border-radius: 0.7rem;
                cursor: pointer;

                svg {
                    font-size: 1.3rem;
                }

            }

            p {
                position: absolute;
                top: 1px;
                right: 0px;
                transform: translate(0.5vw, 0);
                font-size: 0.7rem;
                background: var(--bg-purple);
                color: white;
                border-radius: 1rem;
                padding: 0.15rem;
                font-family: 'Roboto', sans-serif;
            }

            svg {
                
                color: var(--bg-gray);
            }
        }

        .user {
            margin-left: 1.5vw;
            width: 2.7rem;
            height: 2.7rem;
            background: black;
            border-radius: 90%;
            //background-image: url('https://static-cdn.jtvnw.net/jtv_user_pictures/c43ffb01-21b7-45f0-a003-4846f157c860-profile_image-70x70.png');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
        }

    }
}
</style>