<template>
    <div class="model">
        <div class="card">
            <div class="title">
                <h3>Order: {{item._id}}</h3>
            </div>
            <div class="details">
                <table>
                    <tr >
                        <th> N. </th>
                        <th> Nombre </th>
                        <th> Tipo </th>
                        <th> Precio </th>
                    </tr>
                    <tr v-for=" (details, index) in item.items " :key="index">
                        <td> {{index}} </td>
                        <td> {{details.nombre}} </td>
                        <td> {{details.renta.enabled ? `Renta -  ${  msToDays(details.renta.time - new Date(details.date).getTime()  ) } ` : 'Definitive' }} </td>
                        <td> $55.00</td>
                    </tr>
                </table>
            </div>
            <div class="botones">
                <button @click=" $emit('close') "> Salir </button>
            </div>
        </div>
        
    </div>
</template>

<script>
export default {
    name: "Details",
    props: {
        item: Object
    },
    methods:{ 
        msToDays(t) {
            var cd = 24 * 60 * 60 * 1000,
                ch = 60 * 60 * 1000,
                d = Math.floor(t / cd),
                h = Math.floor( (t - d * cd) / ch),
                m = Math.round( (t - d * cd - h * ch) / 60000),
                pad = function(n){ return n < 10 ? '0' + n : n; };
                if( m === 60 ){
                    h++;
                    m = 0;
                }
                if( h === 24 ){
                    d++;
                    h = 0;
                }
            return [`${d}d`, `${pad(h)}h`, `${pad(m)}m`].join(':');
        },
    }

};
</script>

<style lang="scss" scoped>
.model {
    width: 100%;
    height: 100%;
    position: absolute;
    background: rgba(128, 128, 128, 0.397);
    backdrop-filter: blur(8px);
    top: 0;
    left: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    padding-bottom: 5rem;
    z-index: 1;
    font-family: 'Manrope', sans-serif;

    @media screen and (max-width: 768px)  {
        left: 0;
    }
    .card {
        width: 30vw;
        height: 50vh;
        background: white;
        padding: 1vh 1rem;

        @media screen and (max-width: 768px)  {
            width: 100vw;
        }
        


        .details {
            width: 100%;
            height: 82%;
            background: transparent;
            overflow: auto;

            
            
            .detalle {
                display: flex;

                .id {
                    width: 10%;
                }

                .name {
                    width: 35%;
                }

                .status {
                    width: 30%;
                }

                .price {
                    width: 17%;
                    margin-left: 1ch;
                    background: transparent;
                }
            }

            table {
                overflow: auto;
                margin-top: 2vh;
                width: 97%;
                text-align: left;
                border-collapse: collapse;
                color: white;

                th,
                td {
                    padding: 0.7rem;
                    font-size: 0.9rem;
                    text-transform: uppercase;
                }

                @media screen and (max-width: 768px) {
                    font-size: 0.7rem;
                    
                    th,
                    td {
                        padding: 0.35rem;
                    }
                }

                tr {
                    background: var(--bg-purple);
                    &:nth-child(even) {
                        background: var(--low-purple);
                    }
                }

                button {
                    padding: 0.5rem 1rem;
                    color: white;
                    background: var(--col-blue);
                    border-radius: 0.3rem;
                    cursor: pointer;

                    @media screen and (max-width: 768px) {
                        padding: 0.3rem 0.5rem;
                        font-size: 0.7rem;
                    }
                }
            }
        }

        .botones {
            width: 100%;
            margin-top: 1vh;
            display: flex;
            justify-content: center;
            button {
                padding: 0.5rem 3rem;
                background: var(--col-blue);
                color: white;
                cursor: pointer;
            }
        }

        
    }
}
</style>
