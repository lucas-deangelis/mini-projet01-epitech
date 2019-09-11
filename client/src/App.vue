<template>
  <div id="app">
    <!-- Navbar -->
    <div id="navbar">
      <b-navbar toggleable="lg" type="dark" variant="dark" sticky="true">
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
        <div id="clock">

        </div>
        <!-- Working time module -->
        <div id="workingtime">

        </div>
      </div>

      <div class="content">
        <!-- Chart 1 -->
        <div class="chart">

        </div>
        <!-- Chart 2 -->
        <div class="chart">

        </div>
        <!-- Chart 3 -->
        <div class="chart">

        </div>
      </div>

    </div>
  </div>
</template>

<script>
import UserComponent from './components/UserComponent.vue'

export default {
  name: 'app',
  components: {
    UserComponent
  }
}
</script>

<style>
@import url('assets/css/style.css');
</style>
