<template>
  <!--<div class="content" v-if="userLoggedIn">-->
    <div>
        <!-- Clock module -->
        <ClockManagerComponent></ClockManagerComponent>

        <!-- Working time module -->
        <WorkingTimesComponent></WorkingTimesComponent>

      <!--<div class="content" v-if="userLoggedIn">-->
      <div>
        <ChartManagerComponent></ChartManagerComponent>
      </div>

    </div>

</template>

<script>
import ClockManagerComponent from './ClockManagerComponent.vue'
import WorkingTimesComponent from './WorkingTimesComponent.vue'
import ChartManagerComponent from './ChartManagerComponent.vue'

export default {
  name: 'app',
  data() {
    return {
      'userLoggedIn': false
    }
  },
  components: {
    ClockManagerComponent,
    WorkingTimesComponent,
    ChartManagerComponent
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