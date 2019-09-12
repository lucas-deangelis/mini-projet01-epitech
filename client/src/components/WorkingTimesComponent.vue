<template>
    <div id="workingtime" class="div-content">
        <div class="sub sub-header">
            <span><h2>Working Times</h2></span>
            <!-- <b-button variant="dark" v-b-modal.modal-add>ADD</b-button> -->
        </div>
        <div class="sub sub-content">
            <b-table sticky-header head-variant="light" :items="workingtimes" id="workingtimes-table">
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
            userId: 1,
            fields: ['id', 'start', 'end', 'action'],
            workingtimes: [
            ]
        }
    },

    components: {

    },

    mounted() {
        this.getWorkingTimes();
    },

    methods: {
        getWorkingTimes() {
            let url = window.apiUrl + '/api/workingtimes/' + this.userId + '?start=' + '' + '&end=' + '';  //+ this.$root.user.id;

            window.axios.get(url)
            .then(response => {
                // parse the data
                let workingTimesDatas = JSON.parse(JSON.stringify(response.data.data));
                let parsedWorkingTimes = [];

                for (const item of workingTimesDatas) {
                    parsedWorkingTimes.push({
                        'id': item.id,
                        'start': item.start.replace('T', ' '),
                        'end': item.end.replace('T', ' ')
                    });
                }

                // assign the parsed datas to our workingtimes
                this.workingtimes = parsedWorkingTimes;
            })
            .catch(error => {
                console.error(error);
            });
        }
    }
}

</script>