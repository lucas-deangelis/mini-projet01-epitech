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
import { mapState, mapActions } from 'vuex'

export default {
    name: 'User',

    computed:
        mapState({
            user: state => state.user.user
        }),

    mounted() {
        this.$store.dispatch('getUser', 1);
    },

    methods: {

    }
}

</script>