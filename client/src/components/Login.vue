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
		}
	},
	components: {},
	methods: {
		handleLoginSubmit(e) {
			this.$router.push("/");
		},
	}
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>