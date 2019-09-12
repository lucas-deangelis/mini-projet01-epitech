<template>
    <b-dropdown id="dropdown-user" right variant="dark" text="User" class="m-2">
        <b-dropdown-text><label class="font-weight-bold">Id :</label> {{ user.id }} </b-dropdown-text>
        <b-dropdown-text><label class="font-weight-bold">Username :</label> {{ user.username }} </b-dropdown-text>
        <b-dropdown-text><label class="font-weight-bold">Email :</label> {{ user.email }} </b-dropdown-text>
        <!-- <b-dropdown-divider></b-dropdown-divider>
        <b-dropdown-item variant="danger" href="#">Logout</b-dropdown-item> -->
    </b-dropdown>

</template>


<script>
// This component defines an User.
// The user data is fetched from the api.

export default {
    name: 'User',

    props: [
        
    ],

    data() {
        return {
            'userId': 1,
            'user' : {
                'id': null,
                'username': null,
                'email': null
            }
        }
    },

    components: {

    },

    mounted() {
        // call getUser
        this.getUser();

    },

    methods: {
        // getUser from the api and assign it to our client User
        getUser() {
            let url = window.apiUrl + '/api/users/' + this.userId;
            
            window.axios.get(url)
            .then(response => {
                this.user = JSON.parse(JSON.stringify(response.data.data));
                this.$root.user.id = this.user.id;
                this.$root.user.username = this.user.username;
                this.$root.user.email = this.user.email;
            })
            .catch(error => {
                console.error(error);
            });
        },

        createUser() {

        },

        updateUser() {

        },

        deleteUser() {

        }
    }
}

</script>