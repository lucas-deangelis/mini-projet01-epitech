<template>
  <div id="app">
    <!-- Navbar -->
    <div id="navbar">
      <b-navbar toggleable="md" type="dark" variant="dark" sticky>
        <b-navbar-brand href="#">Gotham - A Time Manager</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>


        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="navbar-links mr-auto ml-auto">
            <router-link to="/" class="nav-link">Home</router-link>
            <router-link to="/team" v-if="isUserAdminOrManager()" class="nav-link">Team</router-link>
            <router-link to="/users" v-if="isUserAdmin()" class="nav-link">Users</router-link>
          </b-navbar-nav>

            <div id="user-links-collapsed">
              <li class="nav-item">
                <a class="nav-link text-primary" href="#" v-b-modal.modal-edit>Edit account</a>
              </li>
              <li class="nav-item">
                <a class="nav-link text-danger" href="#" v-b-modal.modal-delete>Delete account</a>
              </li>
            </div>

        </b-collapse>
        <!-- Right aligned nav items -->
        <b-navbar-nav id="user-links">
            <UserComponent @userLoggedIn="setUserLoggedIn"></UserComponent>
        </b-navbar-nav>
      </b-navbar>
    </div>

    <!-- Content -->
    <div id="main-content" class="container-fluid">
      <router-view></router-view>
    </div>
    
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
        return false;
      },

      isUserAdmin(){
        if(this.userRole == 'admin'){
          return true;
        }
        return false;
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
