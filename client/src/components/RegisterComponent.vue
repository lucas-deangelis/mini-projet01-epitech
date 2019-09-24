<template>
	<div id="register" class="div-content content d-flex flex-column justify-content-center">
		<div class="sub sub-header">
			<h1 class="text-dark">Register</h1>
		</div>
		<div class="sub sub-content col-6 ml-auto mr-auto">
			<b-form @submit="onSubmit" @reset="onReset" v-if="showForm">
				<b-form-group id="input-group-1" label="Email address" label-for="input-1" description="We'll never share your email with anyone else.">
					<b-form-input id="input-1" v-model="form.email" type="email" required placeholder="batman@gothamcity.com"></b-form-input>
				</b-form-group>

				<b-form-group id="input-group-2" label="Username" label-for="input-2">
					<b-form-input id="input-2" v-model="form.username" required placeholder="Batman"></b-form-input>
				</b-form-group>

				<b-form-group id="input-group-3" label="Password" label-for="input-3">
					<b-form-input type="password" id="input-3" v-model="form.password" required></b-form-input>
					<b-form-invalid-feedback :state="validationPassword">
						Your password must be minimum 6 characters long.
					</b-form-invalid-feedback>
					<b-form-valid-feedback :state="validationPassword">
						Perfect!
					</b-form-valid-feedback>
				</b-form-group>

				<b-form-group id="input-group-4" label="Confirm Password" label-for="input-4">
					<b-form-input type="password" id="input-4" v-model="form.password_confirmation" required></b-form-input>
					<b-form-invalid-feedback :state="validationConfirmation">
						It must be the same password.
					</b-form-invalid-feedback>
					<b-form-valid-feedback :state="validationConfirmation">
						Sweet!
					</b-form-valid-feedback>
				</b-form-group>
				
				<div class="form-row justify-content-around">
					<b-button type="reset" variant="danger">Reset</b-button>
					<b-button type="submit" variant="primary">Submit</b-button>
				</div>

				<div class="d-flex justify-content-center align-items-center mt-5">
					<p>
						You already have an account ?
						<b-link href="/#/login" class="card-link text-yellow">Click here to login.</b-link>
					</p>
				</div>
			</b-form>
			<b-card title="Congratulation!" v-if="showSubmitted">
				<b-card-text>
					You have been succesfully registered, welcome into the future of <b class="text-yellow">Gotham City</b> track-management system.
				</b-card-text>

				<b-card-text>You can now login and discover what you can do for a better worktime process.</b-card-text>

				<b-link href="/#/login" class="card-link text-yellow">Click here to login.</b-link>
  		</b-card>
		</div>
	</div>
</template>

<script>
import { mapState, mapActions } from 'vuex'

export default {
	data () {
		return {
			form: {
				email: '',
				username: '',
				password: '',
				password_confirmation: ''
			},
			showForm: true,
			showSubmitted: false
		}
	},
	computed: {
		validationPassword() {
			return this.form.password.length > 5
		},
		validationConfirmation() {
			return this.form.password_confirmation == this.form.password && this.form.password_confirmation != ''
		},
	},
	methods: {
		onSubmit(evt) {
			evt.preventDefault()

			this.$store.dispatch('user/createUser', JSON.parse(JSON.stringify(this.form))).then(() => {
				this.showSubmitted = true
				this.showForm = false
				this.form.reset()
			})

		},
		onReset(evt) {
			evt.preventDefault()
			// Reset our form values
			this.form.email = ''
			this.form.username = ''
			this.form.password = ''
			this.form.password_confirmation = ''
			// Trick to reset/clear native browser form validation state
			this.showForm = false
			this.showSubmitted = false
			this.$nextTick(() => {
				this.showForm = true
			})
		}
	}
};
</script>