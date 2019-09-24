<template>
	<div class="sub sub-content">
		<div class="row content d-flex justify-content-center mt-5 ml-2 mr-2">
			<b-card bg-variant="dark" class="rounded-lg">
				<div class="col-md-8">
					<div class="sub sub-header col-md-6">
						<h1 class="text-warning">Login</h1>
					</div>
					<form @submit.prevent="handleLoginSubmit">
						<div class="form-group">
							<label for="username" class="text-warning">Username</label>
							<input type="text" v-model="login.username" name="username"/>
						</div>
						<div class="form-group">
							<label htmlFor="password" class="text-warning">Password</label>
							<input type="password" v-model="login.ypassword" name="password"/>
						</div>
						<div class="form-group text-warning" >
							<button class="btn btn-primary rounded-pill btn-warning col-md-6">Login</button>
						</div>
					</form>
				</div>
			</b-card>
			<b-card bg-variant="transparent" class="border-0 ml-5">
				<div class="col-md-8">
					<div class="sub sub-header col-md-6">
						<h1 class="text-dark">Register</h1>
					</div>
					<form @submit.prevent="handleRegisterSubmit">
						<div class="form-group">
							<label for="firstName">First Name</label>
							<input type="text" v-model="register.firstName" v-validate="'required'" name="firstName"/>
						</div>
						<div class="form-group">
							<label for="lastName">Last Name</label>
							<input type="text" v-model="register.lastName" v-validate="'required'" name="lastName"/>
						</div>
						<div class="form-group">
							<label for="username">Username</label>
							<input type="text" v-model="register.username" v-validate="'required'" name="username"/>
						</div>
						<div class="form-group">
							<label for="username">Email</label>
							<input type="text" v-model="register.email" v-validate="'required'" name="email"/>
						</div>
						<div class="form-group">
							<label htmlFor="password">Password</label>
							<input type="password" v-model="register.password" v-validate="{ required: true, min: 6 }" name="password"/>
						</div>
						<div class="form-group">
							<button class="btn btn-primary">Register</button>
						</div>
					</form>
				</div>
			</b-card>
		</div>
	</div>
</template>

<script>
import Vue from 'vue'
export default {
	name: 'login',
	data() {
		return {
			login:  {
				username: '',
				password: ''
			},
			register: {
				firstName: '',
				lastName: '',
				username: '',
				email: '',
				password: ''
			}
		}
	},
	components: {},
	methods: {
		handleLoginSubmit(e) {
			this.$router.push("/");
		},
		handleRegisterSubmit(e) {

		}
	}
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>