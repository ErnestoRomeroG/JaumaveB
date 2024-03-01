<template>
    <!--  v-bind:style=" { 'borderLeft': `4px solid ${color} ` } " -->
    <div class="card">
        <div class="icon">
            <slot></slot>
        </div>
        <div class="info">
            <h3> {{title}} </h3>
            <p> {{info}} </p>
        </div>  
        
        <p class="desc">  {{ desc }} </p>
        
    </div>
</template>

<script>
export default {
    name: 'Card',
    props: {
        color: {
            Type: String,
            default: '#FF0000'
        },
        title: {
            Type: String,
            default: ''
        },
        info: {
            Type: String,
            default: ''
        },
        desc: {
            Type: String,
            default: ''
        }
    }
}
</script>

<style lang="scss" scoped>
.card {
    width: 15vw;
    height: 22vh;
    background: var(--navbar);
    border-radius: 10px;

    padding-left: 1.5vw;
    padding-right: 2.3vw;
    

    font-family: "Segoe UI",'Roboto',"Helvetica Neue",Arial,sans-serif;

    .info {
        
        text-transform: capitalize;
        color: rgb(173, 173, 173);
        text-align: center;
        span {
            font-size: 1rem;
            
        }

        p {
            margin-top: 5px;
            font-size: 1.1rem;
            font-weight: bold;
            
        }
    }

    .icon {
        
        width: 100%;
        height: 10vh;
        background: transparent;
        color: var(--bg-gray);
        font-size: 2.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
            
        
    }

    .desc {
        margin-top: 1vh;
        text-align: center;
        color: gray;
        font-weight: bold;
    }
}
</style>