<template>
  <div id="app">
    <!-- Navbar -->
    <div id="navbar">
      <b-navbar toggleable="md" type="dark" variant="dark" sticky>
        <b-navbar-brand class="text-yellow" href="#">Gotham - A Time Manager</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>


        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="navbar-links mr-auto ml-auto" v-if="userStatus.isAuthenticated">
            <router-link to="/" class="nav-link text-yellow">Home</router-link>
            <router-link to="/team" class="nav-link text-yellow">Teams</router-link>
            <router-link to="/users" class="nav-link text-yellow">Users</router-link>

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
        <b-navbar-nav v-if="userStatus.isAuthenticated" id="user-links">
            <UserComponent></UserComponent>
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
import { mapState } from 'vuex'

export default {
  name: 'app',
  data() {
    return {}
  },
  computed: {
    ...mapState('user', {
      user: state => state.user,
      userStatus: state => state.userStatus
    })
  },
  components: {
    UserComponent
  },
  methods: {}
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>
