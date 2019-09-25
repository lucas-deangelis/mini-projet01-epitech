import Vue from 'vue'
import App from './components/App.vue'

import store from './store'

// Bootstrap file for axios
require('./bootstrap');

// Bootstrap css
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

//Importing Vue Router to do our routing
import VueRouter from 'vue-router'
import routes from './routes'

Vue.use(BootstrapVue)
Vue.use(VueRouter)

Vue.config.productionTip = false

const router = new VueRouter({routes})


// Check if user is authenticated and if he can access pages without

router.beforeEach((to, from, next) => {

  const publicPages = ['/login', '/register'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = store.getters['user/getIsAuthenticated'];

  console.log(loggedIn);

  if (!authRequired && loggedIn)
    return next('/');
  if (authRequired && !loggedIn) {
    return next('/login');
  }

  next();
})

// Instantiate the VUE and attach it to #app
const app = new Vue({
  store,
  router,
  render: h => h(App)
}).$mount('#app')
