<template>
    <div class="mod">
        
        <table>
            <tr>
                <th> ID </th>
                <th> Titulo </th>
                <th> Estado </th>
                <th>  </th>
            </tr>
            <tr v-for=" (item) in Tickets " :key="item._id">
                <td> {{ item._id }} </td>
                <td> {{ item.title }} </td>
                <td> {{ item.status }} </td>
                <td> <button title=" Ver ticket "  @click=" $emit('see', item._id) " > Mirar </button> </td>
                
            </tr>
        </table>
    </div>
</template>

<script>
export default {
    name: "ViewTicket",
    props: {
        Tickets: {
            type: Array,
        },
    },
    data() {
        return {
            
        }
    },
    mounted() {
        
    },
};
</script>

<style lang="scss" scoped>
.mod {
    width: 100%;
    height: 100%;
    color: black;
    font-family: "Manrope", sans-serif;
    padding: 0.5vmax 0.5vmax;
    overflow-y: auto;

    table {
        overflow: auto;
        width: 100%;
        text-align: left;
        border-collapse: collapse;
        color: black;
        font-family: "Manrope", sans-serif;

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
            background: transparent;
            border-bottom: 1px solid rgba(0, 0, 0, 0.13);
            &:nth-child(even) {
                background: transparent;
            }
        }

        button {
            padding: 0.5rem 1rem;
            color: white;
            background: var(--col-blue);
            border-radius: 0.3rem;
            cursor: pointer;

            &.ban {
                background: var(--col-red);
            }

            @media screen and (max-width: 768px) {
                padding: 0.3rem 0.5rem;
                font-size: 0.7rem;
            }
        }
    }
}
</style>
