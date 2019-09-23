<template>
  <div id="app">
    <!-- Navbar -->
    <div id="navbar">
      <b-navbar toggleable="lg" type="dark" variant="dark" sticky>
        <b-navbar-brand href="#">Gotham - A Time Manager</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>


        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="navbar-links mr-auto ml-auto">
            <router-link to="/" class="nav-link">Home</router-link>
            <router-link to="/team" v-if="isUserAdminOrManager()" class="nav-link">Team</router-link>
            <router-link to="/users" v-if="isUserAdmin()" class="nav-link">Users</router-link>
          </b-navbar-nav>

          <!-- Right aligned nav items -->
          <b-navbar-nav>
              <UserComponent @userLoggedIn="setUserLoggedIn"></UserComponent>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>
    </div>

    <!-- Content -->
    <router-view></router-view>
    
  </div>
</template>

<script>
import UserComponent from './UserComponent.vue'
import { mapGetters, mapState, mapActions } from 'vuex'

export default {
  name: 'app',
  data() {
    return {
      'userLoggedIn': false,
    }
  },

  components: {
    UserComponent
  },
  methods: {
      setUserLoggedIn(loggedIn) {
          this.userLoggedIn = loggedIn;
      },

      isUserAdminOrManager(){
        if(this.userRole == 'admin' || 'manager'){
          return true;
        }
      },

      isUserAdmin(){
        if(this.userRole == 'admin'){
          return true;
        }
      }

  },

  computed:{
    ...mapGetters({
        userRole: 'user/getUserRole'
    })

  }

}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>
