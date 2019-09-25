<template>
	<div id="login" class="div-content content d-flex flex-column justify-content-center">
		<div class="sub sub-header">
			<h1 class="text-yellow">Gotham - A Time Manager</h1>
		</div>
		<div class="sub sub-header">
			<h2 class="text-dark">Login</h2>
		</div>
		<div class="sub sub-content col-6 ml-auto mr-auto">
			<b-form @submit.prevent="handleLoginSubmit">
				<b-form-group id="input-group-1" label="Email" label-for="input-1">
					<b-form-input type="email" v-model="login.email" name="email" required /></b-form-input>
				</b-form-group>
				<b-form-group id="input-group-2" label="Password" label-for="input-2">
					<b-form-input type="password" v-model="login.password" name="password" required /></b-form-input>
				</b-form-group>
				<div class="form-row justify-content-around mt-3">
					<b-button type="submit" variant="warning" class="col-md-6">Login</b-button>
				</div>
				<div class="d-flex justify-content-center align-items-center mt-5">
					<p>
						You don't have an account ?
						<b-link href="/#/register" class="card-link text-yellow">Click here to register.</b-link>
					</p>
				</div>
			</b-form>
		</div>
	</div>
</template>

<script>
import { mapState, mapActions } from 'vuex'

export default {
	name: 'login',
	data() {
		return {
			login:  {
				email: '',
				password: ''
			}
		}
	},
	computed: {
		...mapState('user', {
			userStatus: state => state.userStatus
		})
	},
	components: {},
	methods: {
		handleLoginSubmit(e) {
			this.$store.dispatch('user/login', this.login).then(() => {
				if (this.userStatus.isAuthenticated == true) this.$router.push('/')
			})
		}
	}
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>