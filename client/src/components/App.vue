<template>
  <div id="app">
    <!-- Navbar -->
    <div id="navbar">
      <b-navbar toggleable="lg" type="dark" variant="dark" sticky>
        <b-navbar-brand href="#">Gotham - A Time Manager</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>

          <!-- Right aligned nav items -->
          <b-navbar-nav class="ml-auto">
              <UserComponent @userLoggedIn="setUserLoggedIn"></UserComponent>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>
    </div>

    <!-- Content -->

    <div id="main-content">

      <div class="content" v-if="userLoggedIn">
        <!-- Clock module -->
        <ClockManagerComponent></ClockManagerComponent>

        <!-- Working time module -->
        <WorkingTimesComponent></WorkingTimesComponent>
      </div>

      <div class="content" v-if="userLoggedIn">
        <ChartManagerComponent></ChartManagerComponent>
      </div>
      <div class="content" v-if="userLoggedIn">
        <AdminComponent></AdminComponent>
      </div>

    </div>
  </div>
</template>

<script>
import UserComponent from './UserComponent.vue'
import ClockManagerComponent from './ClockManagerComponent.vue'
import WorkingTimesComponent from './WorkingTimesComponent.vue'
import ChartManagerComponent from './ChartManagerComponent.vue'

import AdminComponent from './AdminComponent.vue'

export default {
  name: 'app',
  data() {
    return {
      'userLoggedIn': false
    }
  },
  components: {
    UserComponent,
    ClockManagerComponent,
    WorkingTimesComponent,
    ChartManagerComponent,
    AdminComponent
  },
  methods: {
      setUserLoggedIn(loggedIn) {
          this.userLoggedIn = loggedIn;
      }
  }
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>
