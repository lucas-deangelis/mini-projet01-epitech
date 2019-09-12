<template>
    <div>
        <H1>Récuperer les utilisateurs</H1>
    </div>
</template>


<script>
// This component defines an User.
// The user data is fetched from the api.

export default {
    name: 'User',

    props: [
        'user'
    ],

    data() {
        return {
            id: '',
            username: '',
            email: ''
        }
    },

    components: {

    },

    mounted() {
        getUser: {
            let url = window.apiUrl + '/api/users/' + 1;//this.userID;

            window.axios.get(url)
            .then(response => {
                this.user = response.data;
            })
            .then(response => {
                console.print(response.data);
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