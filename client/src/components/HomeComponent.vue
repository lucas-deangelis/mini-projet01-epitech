<template>
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

</template>

<script>
import ClockManagerComponent from './ClockManagerComponent.vue'
import WorkingTimesComponent from './WorkingTimesComponent.vue'
import ChartManagerComponent from './ChartManagerComponent.vue'

export default {
  name: 'app',
  components: {
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