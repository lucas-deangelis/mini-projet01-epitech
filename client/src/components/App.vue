<template>
  <div id="app">
    <!-- Navbar -->
    <div id="navbar" v-if="userStatus.isAuthenticated">
      <b-navbar toggleable="md" type="dark" variant="dark" sticky>
        <b-navbar-brand class="text-yellow" href="#">Gotham - A Time Manager</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>


        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="navbar-links mr-auto ml-auto">
            <router-link to="/" class="nav-link text-yellow">Home</router-link>
            <router-link to="/team" class="nav-link text-yellow" v-if="user.role == 'manager' || user.role == 'admin'">Teams</router-link>
            <router-link to="/users" class="nav-link text-yellow" v-if="user.role == 'admin'">Users</router-link>

            <div id="user-links-collapsed">
              <li class="nav-item">
                <a class="nav-link text-primary" href="#" v-b-modal.modal-edit>Edit account</a>
              </li>
              <li class="nav-item">
                <a class="nav-link text-danger" href="#" v-b-modal.modal-delete>Delete account</a>
              </li>
            </div>
          </b-navbar-nav>

        </b-collapse>
        <!-- Right aligned nav items -->
        <b-navbar-nav id="user-links">
            <UserComponent></UserComponent>
        </b-navbar-nav>
      </b-navbar>
    </div>

    <!-- Content -->
    <div id="main-content" class="container-fluid">
      <router-view></router-view>
    </div>

    <footer class="footer mt-auto pb-5">
      <div class="container d-flex justify-content-between align-items-center col-4">
        <a href="#" class="text-muted" v-b-modal.modal-accessibility>Accessibility</a>
        <a href="#" class="text-muted" v-b-modal.modal-tools>Tools</a>
        <a href="https://github.com/lucas-deangelis/mini-projet01-epitech" target="_blank" class="text-muted">Github</a>
      </div>
    </footer>

    <!-- Modal accessibility -->
    <b-modal id="modal-accessibility" title="Accessibility" hide-footer>
      <div class="d-block text-justify">
        <p>Press <i><b>Ctrl + Key</b></i> with key as the follow values : </p>
        <ul>
          <li><b>H</b> : Go to home page</li>
          <li><b>T</b> : Go to teams page</li>
          <li><b>U</b> : Go to users page</li>
          <li><b>C</b> : Clock in / Clock out</li>
          <li><b>L</b> : Go to login page and disconnect</li>
          <li><b>R</b> : Go to register page</li>
        </ul>
      </div>
    </b-modal>
    <!-- Modal tools -->
    <b-modal id="modal-tools" title="Tools used for this project" hide-footer>
      <div class="d-block text-justify">
        <p>This is an exhaustiv list of tools used for this project</p>
        <ul>
          <li>Discord (Communication/IRC)</li>
          <li>Trello (Project management)</li>
          <li>VueJS (Front)</li>
          <li>Elixir (Back)</li>
          <li>Phoenix (Framework web)</li>
          <li>Postgresql (Database)</li>
          <li>Cordova (Front to mobile)</li>
          <li>JWT + Argon2 + Guardian (Authentification)</li>
          <li>Heroku (Server Cloud)</li>
          <li>Travis (Continuous Integration)</li>
          <li>Docker + docker-compose (Containerization)</li>
          <li>Bootstrap 4 + Boostrap-Vue + Fontawesome (Design front)</li>
          <li>Stylus (CSS prepocessor)</li>
          <li>Webpack (Bundle JS)</li>
          <li>Moment (Date manipulation in JS)</li>
          <li>Vuex + Vuex-persist (Inapp State management)</li>
          <li>Vue-morris (Chart modelization)</li>
          <li>Corsica (CORS)</li>
          <li>Axios (HTTP call in JS)</li>
          <li>Postman (API testing tool)</li>
        </ul>
      </div>
    </b-modal>
    
  </div>
</template>

<script>
import UserComponent from './UserComponent.vue'
import { mapState } from 'vuex'

export default {
  name: 'app',

  data() {
    return {}
  },

  computed: {
    ...mapState('user', {
      user: state => state.user,
      userId: state => state.user.id,
      userStatus: state => state.userStatus
    })
  },

  components: {
    UserComponent
  },

  mounted() {
    setTimeout(() => {
      // ACCESSIBILITY
      let navigate = this.$router
      let route = this.$route
      let isAuthenticated = this.userStatus.isAuthenticated
      let storeApp = this.$store
      let userAppId = this.userId

      window.addEventListener("keydown", function(event) {

        let preventEvent = true

        if (event.ctrlKey) {
          switch(event.code) {
            case "KeyH":
              // go to home view
              navigate.push('/')
              break
            case "KeyT":
              // go to team view
              navigate.push('/teams')
              break
            case "KeyU":
              // go to home view
              navigate.push('/users')
              break
            case "KeyL":
              // go to login view or logout
              if (isAuthenticated) {
                // flush all the user state
                storeApp.commit('user/setUser', {
                    id: null,
                    username: null,
                    email: null
                })
                storeApp.commit('user/setListUsers', [])
                storeApp.commit('user/setIsAuthenticated', false)
                storeApp.commit('user/setJwt', null)

              }
              // redirect to /login
              navigate.push('/login')
              break
            case "KeyR":
              // go to register view
              if (isAuthenticated) {
                // flush all the user state
                storeApp.commit('user/setUser', {
                    id: null,
                    username: null,
                    email: null
                })
                storeApp.commit('user/setListUsers', [])
                storeApp.commit('user/setIsAuthenticated', false)
                storeApp.commit('user/setJwt', null)

              }
              // redirect to /register
              navigate.push('/register')
              break
            case "KeyC":
              // clock in - clock out
              if (route.name == "home")
                storeApp.dispatch('clock/clock', userAppId)
              break
            default:
              preventEvent = false
              break
            
          }

          if (preventEvent) {
            // Consume the event so it doesn't get handled twice
            event.preventDefault();
          }
        }
      }, false);
    }, 1000);
  }
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>
