<template>
    <div>
        <h2>Login</h2>
        <form @submit.prevent="handleSubmit">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" v-model="username" name="username"/>
            </div>
            <div class="form-group">
                <label htmlFor="password">Password</label>
                <input type="password" v-model="password" name="password"/>
            </div>
            <div class="form-group">
                <button class="btn btn-primary">Login</button>
                <router-link to="/register" class="btn btn-link">Register</router-link>
            </div>
        </form>
    </div>
</template>

<script>
import Vue from 'vue'
export default {
    name: 'login',
    data() {
        return {
            username: '',
            password: '',
            submitted: false
        }
    },
    components: {},
    methods: {
        handleSubmit(e) {
            this.submitted = true;
            this.$router.push("/");
        }
    }
}
</script>