<template>
    <div>
        <h2>Register</h2>
        <form @submit.prevent="handleSubmit">
            <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" v-model="user.firstName" v-validate="'required'" name="firstName"/>
            </div>
            <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" v-model="user.lastName" v-validate="'required'" name="lastName"/>
            </div>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" v-model="user.username" v-validate="'required'" name="username"/>
            </div>
            <div class="form-group">
                <label for="username">Email</label>
                <input type="text" v-model="user.email" v-validate="'required'" name="email"/>
            </div>
            <div class="form-group">
                <label htmlFor="password">Password</label>
                <input type="password" v-model="user.password" v-validate="{ required: true, min: 6 }" name="password"/>
            </div>
            <div class="form-group">
                <button class="btn btn-primary">Register</button>
                <router-link to="/login" class="btn btn-link">Cancel</router-link>
            </div>
        </form>
    </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'

export default {
    data () {
        return {
            user: {
                firstName: '',
                lastName: '',
                username: '',
                email: '',
                password: ''
            },
            submitted: false
        }
    },
    computed: {
        ...mapState('account', ['status'])
    },
    methods: {
        ...mapActions('account', ['register']),
        handleSubmit(e) {
            this.submitted = true;
            this.$validator.validate().then(valid => {
                if (valid) {
                    this.register(this.user);
                }
            });
        }
    }
};
</script>