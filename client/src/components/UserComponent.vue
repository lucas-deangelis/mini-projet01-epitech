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
            let url = window.apiUrl + '/api/users/' + this.userID;

            window.axios.get(url)
            .then(response => {
                this.user = response.data;
            })
            .catch(error => {
                print(error);
            });
        }

    },

    methods: {

    }
}

</script>