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
              <UserComponent></UserComponent>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>
    </div>

    <!-- Content -->

    <div id="main-content">

      <div class="content">
        <!-- Clock module -->
        <ClockManagerComponent></ClockManagerComponent>

        <!-- Working time module -->
        <WorkingTimesComponent></WorkingTimesComponent>
      </div>

      <div class="content">
        <ChartManagerComponent></ChartManagerComponent>
      </div>

    </div>
  </div>
</template>

<script>
import UserComponent from './UserComponent.vue'
import ClockManagerComponent from './ClockManagerComponent.vue'
import WorkingTimesComponent from './WorkingTimesComponent.vue'
import ChartManagerComponent from './ChartManagerComponent.vue'

export default {
  name: 'app',
  components: {
    UserComponent,
    ClockManagerComponent,
    WorkingTimesComponent,
    ChartManagerComponent
  }
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>