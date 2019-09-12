<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <!--<HelloWorld msg="Welcome to Your Vue.js App"/>-->
    <UserComponent/>
    <ClockManagerComponent/>
    <WorkingTimesComponent/>
    <WorkingTimeComponent/>
  </div>
</template>

<script>
//import HelloWorld from './components/HelloWorld.vue'
import UserComponent from './components/UserComponent.vue'
import ClockManagerComponent from './components/ClockManagerComponent.vue'
import WorkingTimesComponent from './components/WorkingTimesComponent.vue'
import WorkingTimeComponent from './components/WorkingTimeComponent.vue'

export default {
  name: 'app',
  components: {
    UserComponent
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
