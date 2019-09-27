import Vue from 'vue'
import Vuex from 'vuex'
import user from './modules/user'
import team from './modules/team'
import workingtime from './modules/workingtime'
import clock from './modules/clock'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'


// Listeners to actions and mutations when state change
const listeners = store => {
  // called when the store is initialized
  store.subscribe((mutation, state) => {
    // called after every mutation.
    // The mutation comes in the format of `{ type, payload }`.

  })

  store.subscribeAction({
    before: (action, state) => {
      // called before every action.
      // The action comes in the format of `{ type, payload }`.
    },
    after: (action, state) => {
      // console.log(action)
      // called after every action.
      // The action comes in the format of `{ type, payload }`.
      if (action.type == "user/getUser") {
        store.dispatch('clock/get', action.payload )
        store.dispatch('getWorkingTimes', { userId: action.payload, start: '', end: '' })
        store.dispatch('user/getAllUsers')
        store.dispatch('team/getManagerTeams', action.payload)
        store.dispatch('team/getTeamMembers', action.payload)
      }

      if (action.type == "user/updateUser") {
        store.dispatch('user/getAllUsers')
      }
      
      if (action.type == "user/deleteUser") {
        store.dispatch('user/getAllUsers')
      }
    }
  })
}

export default new Vuex.Store({
  modules: {
    user,
    team,
    workingtime,
    clock
  },
  strict: debug,
  plugins: [listeners]
})