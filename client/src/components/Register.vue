<template>
	<div class="sub sub-content">
		<div class="row content d-flex justify-content-center mt-2">
		</div>
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