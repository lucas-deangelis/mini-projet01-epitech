import Vue from 'vue'
import App from './App.vue'

// Bootstrap file for axios
require('./bootstrap');


// Global components
Vue.component(
    'user-component',
    require('./components/UserComponent.vue')
);


Vue.config.productionTip = false

// Instantiate the VUE and attach it to #app
const app = new Vue({
  render: h => h(App),
}).$mount('#app')
