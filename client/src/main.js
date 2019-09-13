import Vue from 'vue'
import App from './components/App.vue'

import store from './store'

// Bootstrap file for axios
require('./bootstrap');

// Bootstrap css
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
  
Vue.config.productionTip = false
  
// Instantiate the VUE and attach it to #app
const app = new Vue({
  store,
  render: h => h(App),
}).$mount('#app')
