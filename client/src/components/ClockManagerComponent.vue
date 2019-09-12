<template>
    <div>
        <H1>ClockManager</H1>
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
            time:'',
            status:false,
            user:''
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
                print(error);
            });
        }
    },

    methods: {

    }
}

</script>