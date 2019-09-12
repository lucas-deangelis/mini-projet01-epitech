<template>
        <div id="clock" class="div-content">
            <div class="sub sub-header">
                <h2>Clock Manager</h2>
            </div>
            <div class="sub sub-content">
                <div v-if="!clockInProgress">
                    <transition appear name="fade" mode="out-in">
                        <b-button variant="success" v-on:click="clock">Do you want to clock IN ?</b-button>
                    </transition>
                </div>
                <div v-else>
                    <transition appear name="fade" mode="out-in">
                        <b-button variant="danger" v-on:click="clock">Do you want to clock OUT ?</b-button>
                    </transition>
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
            'userId': 1,
            'startDateTime': null,
            'clockInProgress': false
        }
    },

    components: {
    },

    mounted() {
        
    },

    methods: {
        // clock in - clock out
        clock() {
            let url = window.apiUrl + '/api/clocks/' + this.userId;

            window.axios.post(url)
            .then(response => {
                let data = JSON.parse(JSON.stringify(response.data.data));
                
                if (data.status == false) {
                    // update clockInProgress var
                    this.clockInProgress = false;

                    this.refresh();
                } else {
                    // update startDateTime and clockInProgress var
                    this.startDateTime = data.time.replace('T', ' ');
                    this.clockInProgress = true;
                }
            })
            .catch(error => {
                console.error(error);
            });
        },

        // Refresh the workingtimes component
        refresh() {
            // call parent app method to refresh the working times component
            this.$parent.refreshWorkingTimesComponent();
        }
    }
}

</script>