<template>
    <div>
        <H1>Récuperer les utilisateurs</H1>
    <b-nav-item-dropdown right>
        <!-- Using 'button-content' slot -->
        <template v-slot:button-content>
            <span>Username</span>
        </template>
        <b-dropdown-item href="#">Profile</b-dropdown-item>
        <!-- <b-dropdown-item href="#">Sign Out</b-dropdown-item> -->
    </b-nav-item-dropdown>
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