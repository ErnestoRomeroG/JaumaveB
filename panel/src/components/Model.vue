<template>
    <div class="container">
        <div class="titulo">
            <h3> {{title}} </h3> 
            <p> {{Subtitle}} </p>
        </div>
        <p>
            
        </p>
        <slot></slot>
    </div>
</template>

<script>
export default {
    name: 'Model',
    props: {
        title: {
            type: String,
            default: ''
        },
        Subtitle: {
            type: String,
            default: ''
        },
    }
}
</script>

<style lang="scss" scoped>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Thai+Looped&family=Open+Sans&display=swap');


.container {
    width: 20vw;
    height: 25vh;
    background: white;
    padding: 1vh 1vw 1vh 1vw;
    box-shadow: 1px 1px 10px rgba(0, 0, 0, 0.336);
    border-radius: 10px;
    overflow: auto;
    .titulo {
        width: 100%;
        display: flex;
        align-items: center;
        background: transparent;

        font-family: 'IBM Plex Sans Thai Looped', sans-serif;

        p {
            color: gray;
            margin-left: auto;
        }
    }
}
</style>