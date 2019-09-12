<template>
    <b-dropdown id="dropdown-user" right variant="dark" text="User" class="m-2">
        <b-dropdown-text>Id : 1</b-dropdown-text>
        <b-dropdown-text>Username : Username</b-dropdown-text>
        <b-dropdown-text>Email : test@email.com</b-dropdown-text>
        <b-dropdown-divider></b-dropdown-divider>
        <b-dropdown-item variant="danger" href="#">Logout</b-dropdown-item>
    </b-dropdown>

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
            let url = window.apiUrl + '/api/users/1'; //this.userID;
            
            window.axios.get(url)
            .then(response => {
                this.user = response.data;
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