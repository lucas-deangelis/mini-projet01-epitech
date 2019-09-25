<template>
    <b-dropdown id="dropdown-user" right variant="dark" text="User" class="m-2">
        <b-dropdown-header id="dropdown-header-label-account-zone">
            ACCOUNT INFORMATIONS
        </b-dropdown-header>
        <b-dropdown-text><label class="font-weight-bold">Id :</label> {{ user.id }} </b-dropdown-text>
        <b-dropdown-text><label class="font-weight-bold">Username :</label> {{ user.username }} </b-dropdown-text>
        <b-dropdown-text><label class="font-weight-bold">Email :</label> {{ user.email }} </b-dropdown-text>
        <!-- <b-dropdown-divider></b-dropdown-divider> -->
        <!-- <b-dropdown-item variant="danger" href="#">Logout</b-dropdown-item> -->
        <b-dropdown-divider></b-dropdown-divider>
        <b-dropdown-header id="dropdown-header-label-danger-zone">
            DANGER ZONE
        </b-dropdown-header>
        <b-dropdown-item variant="primary" href="#" v-b-modal.modal-edit>Edit account</b-dropdown-item>
        <b-dropdown-item variant="danger" href="#" v-b-modal.modal-delete>Delete account</b-dropdown-item>


        <!-- MODALS -->
        <b-modal id="modal-edit" title="Edit my informations" hide-footer>
            <b-form @submit="onSubmitUpdate">
                <b-form-group id="input-group-1" label="Your username:" label-for="input-1">
                    <b-form-input id="input-1" v-model="form.username" required placeholder="Enter username"></b-form-input>
                </b-form-group>
                <b-form-group id="input-group-2" label="Your email address:" label-for="input-2" description="We'll never share your email with anyone else.">
                    <b-form-input id="input-2" v-model="form.email" type="email" required placeholder="Enter email"></b-form-input>
                </b-form-group>
                <b-button type="submit" variant="primary">Submit</b-button>
            </b-form>
        </b-modal>
        <b-modal id="modal-delete" title="Delete my account" hide-footer>
            <b-form @submit="onSubmitDelete">
                <h3 class="text-danger">DANGER ! You are about to delete your account, this action is irreversible ! Are you sure you want to continue ?</h3>
                <b-button type="submit" variant="danger">Yes delete my account</b-button>
            </b-form>
        </b-modal>
    </b-dropdown>
</template>


<script>
// This component defines an User.
import { mapState, mapActions } from 'vuex'

export default {
    name: 'User',

    data() {
        return {
            form: {
                username: '',
                email: ''
            }
        }
    },

    computed:
        mapState('user', {
            user: state => state.user
        }),

    mounted() {
        //this.$store.dispatch('user/getUser', 1)

        this.$root.$on('bv::modal::shown', (bvEvent, modalId) => {
            this.form.username = this.user.username;
            this.form.email = this.user.email;
            $('#input-1').text(this.user.username)
            $('#input-2').text(this.user.email)
            $('#input-1').val(this.user.username)
            $('#input-2').val(this.user.email)
        })
    },

    methods: {
        // update user when form submitted
        onSubmitUpdate(evt) {
            evt.preventDefault()
            let data = JSON.parse(JSON.stringify(this.form))
            this.$store.dispatch('user/updateUser', { id: this.user.id, email: data.email, username: data.username })

            // close the modal
            this.$root.$emit('bv::hide::modal', 'modal-edit')
        },
        // delete user when form submitted
        onSubmitDelete(evt) {
            evt.preventDefault()
            this.$store.dispatch('user/deleteUser', { id: this.user.id})

            // close the modal
            this.$root.$emit('bv::hide::modal', 'modal-delete')

            // call logout action

        },
    }
}

</script>