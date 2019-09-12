<template>
    <div>
        <H1>Récuperer un workingtime</H1>
    </div>
</template>

<script>
// This component defines a WorkingTime.

export default {
    name: 'WorkingTime',

    props: [
        'workingtime'
    ],

    data() {
        return {
            start:'',
            end:'',
            user:''
        }
    },

    components: {

    },

    mounted() {
        getWorkingTime: {
            let url = window.apiUrl + '/api/workingtimes/' + this.userID;

            window.axios.get(url)
            .then(response => {
                this.workingtimes = response.data;
            })
            .catch(error => {
                console.error(error);
            });
        }
    },

    methods: {

    }
}

</script>