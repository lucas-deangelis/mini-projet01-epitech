<template>
    <div id="clock" class="div-content">
        <div class="sub sub-header">
            <h2>Clock Manager</h2>
        </div>
        <div class="sub sub-content">
            <div v-if="!clockInProgress">
                <b-button variant="success" :pressed.sync="clockInProgress">Do you want to clock IN ?</b-button>
            </div>
            <div v-else>
                <b-button variant="danger" :pressed.sync="clockInProgress">Do you want to clock OUT ?</b-button>
            </div>
        </div>
    </div>

</template>


<script>
// This component defines the Clock manager.

export default {
    name: 'ClockManager',

    props: [
        'clockmanager'
    ],

    data() {
        return {
            startDateTime: null,
            clockInProgress: false
        }
    },

    components: {

    },

    mounted() {
        clockManager: {
            let url = window.apiUrl + '/api/clock/' + this.userID;

            window.axios.get(url)
            .then(response => {
                this.clockmanager = response.data;
            })
            .catch(error => {
                //console.error(error);
            });
        }
    },

    methods: {

    }
}

</script>