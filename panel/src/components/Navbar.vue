<template>
    <div class="content">
        <div class="image">
            <img src="../assets/jaumave.jpg" alt="" loading="lazy">
        </div>

        <nav>
            <!--
            <router-link to="/">
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['fas', 'home'] " />
                    </div>
                </div>
            </router-link> -->

            <router-link to="/publicaciones" :class=" [$route.path.indexOf('/publicaciones') !== -1 ? 'router-link-exact-active' : ''] " >
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['far', 'pen-to-square'] " />
                    </div>
                </div>
            </router-link> 

            <router-link to="/eventos">
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['far', 'calendar'] " />
                    </div>
                </div>
            </router-link> 

            <!--
            
            <router-link to="/categorias" :class=" [$route.path.indexOf('/categorias') !== -1 ? 'router-link-exact-active' : ''] ">
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['fas', 'list'] " />
                    </div>
                </div>
            </router-link> 

            <router-link to="/membresias" :class=" [$route.path.indexOf('/membresias') !== -1 ? 'router-link-exact-active' : ''] ">
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['fas', 'id-card'] " />
                    </div>
                </div>
            </router-link> 

            <router-link to="/user">
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['fas', 'user'] " />
                    </div>
                </div>
            </router-link> 


            <router-link to="/refund">
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['fas', 'cog'] " />
                    </div>
                </div>
            </router-link>  -->

            <!--<a @click="$root.logout()">
                <div class="box">
                    <div class="circulo">
                        <font-awesome-icon :icon=" ['fas', 'sign-out-alt'] " />
                    </div>
                </div>
            </a> -->

            
        </nav>
    </div>
</template>

<script>
export default {
    name: 'navbar',

}
</script>

<style lang="scss" scoped>

@mixin center() {
    display: flex;
    justify-content: center;
    align-items: center;
}

.content {
    position: fixed;
    width: 5vw;
    min-height: 100vh;
    background: var(--navbar);
    z-index: 3;

    .image {
        height: 9vh;
        width: 100%;
        
        @include center();
        
        img {
            height: 80%;
            border-radius: 4px;
            
        }

        &::before {
            content: '';
            position: absolute;
            display: flex;
            height: 1px;
            width: 3vw;
            background: rgba(104, 104, 104, 0.288);
            margin-top: 9vh;
        }
    }


    nav {
        margin-top: 1vh;
        width: 100%;
        height: 70%;

        a {
            text-decoration: none;
            color: var(--bg-gray);
            transition: all 0.2s ease;
            .box {
                width: 100%;
                height: 7vh;
                background: transparent;
                transition: all 0.2s ease;
                @include center();

                .circulo {
                    @include center();
                    height: 90%;
                    width: 70%;
                    background: var(--bg-body);
                    border-radius: 0.7rem;

                    svg {
                        font-size: 1.2rem;
                    }
                }
            }

            &.router-link-exact-active {
                color: white;
                
                .box {
                    .circulo {
                        background: #9357ee;
                    }
                }
            }
        }

        
        
    }
}
</style>