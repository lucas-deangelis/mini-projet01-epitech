import Vue from 'vue'
import Vuex from 'vuex'
import user from './modules/user'
import workingtime from './modules/workingtime'
import clock from './modules/clock'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
    user,
    workingtime,
    clock
  },
  strict: debug,
  plugins: []
})