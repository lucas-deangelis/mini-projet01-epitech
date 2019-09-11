<template>
    <div id="workingtime" class="div-content">
        <div class="sub sub-header">
            <span><h2>Working Times</h2></span>
            <b-button variant="dark" v-b-modal.modal-add>ADD</b-button>
        </div>
        <div class="sub sub-content">
            <b-table sticky-header head-variant="light" :items="items" id="workingtimes-table">
                <template v-slot:cell(action)="row">
                    <b-button variant="primary" size="sm" @click="row.showDetails" class="mr-2" v-b-tooltip.hover title="Show">
                        <i class="fas fa-eye"></i>
                    </b-button>
                    <b-button variant="danger" size="sm" @click="row.delete" class="mr-2" v-b-tooltip.hover title="Delete">
                        <i class="fas fa-trash-alt"></i>
                    </b-button>
                </template>
            </b-table>
        </div>

        <b-modal id="modal-add" title="Add a working time">
            <p class="my-4">Hello from modal!</p>
        </b-modal>
    </div>
</template>



<script>
// This component defines many WorkingTimes.

export default {
    name: 'WorkingTimes',

    props: [
    ],

    data() {
        return {
            fields: ['id', 'start', 'end', 'action'],
            items: [
                { id: 40, start: '2019-12-09 12:00:10', end: '2019-12-09 12:00:10', action: "" },
                { id: 21, start: '2019-11-25 10:50:00', end: '2019-11-25 10:50:00', action: "" },
                { id: 89, start: '2019-10-01 08:25:10', end: '2019-10-01 08:25:10', action: "" },
                { id: 38, start: '2019-08-07 19:00:10', end: '2019-08-07 19:00:10', action: "" }
            ]
        }
    },

    components: {

    },

    mounted() {

    },

    methods: {

    }
}

</script>