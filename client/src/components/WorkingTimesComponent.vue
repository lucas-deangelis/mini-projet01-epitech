<template>
    <div>
        <H1>Récuperer les WorkingTimes</H1>
    </div>
</template>

<script>
// This component defines many WorkingTimes.

export default {
    name: 'WorkingTimes',

    props: [
        'workingtimes'
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
        getWorkingTimes: {
            let url = window.apiUrl + '/api/workingtimes/' + this.userID;

            window.axios.get(url)
            .then(response => {
                this.workingtimes = response.data;
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