<template>
    <div id="main-content" class="container-fluid">

      <div class="row content">
        <!-- Clock module -->
        <div class="col-md-4">
          <ClockManagerComponent></ClockManagerComponent>
        </div>
        <!-- Working time module -->
        <div class="col-md-8">
          <WorkingTimesComponent></WorkingTimesComponent>
        </div>
      </div>
      <div class="row content">
        <div class="col-md-4">
          <ChartManagerComponent></ChartManagerComponent>
        </div>
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