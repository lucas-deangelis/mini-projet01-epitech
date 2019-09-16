// initial state
const state = {
  startDateTime: null,
  clockInProgress: false
}

// getters
const getters = { 
  getClockInProgress: state => {
    return state.clockInProgress
  },
  getStartDateTime: state => {
    return state.startDateTime
  },
}

// actions
const actions = {
  // clock in - clock out
  clock({ commit, state, rootState }) {
    console.log(rootState.user.user.id)
    let url = window.apiUrl + '/api/clocks/' + 1

    window.axios.post(url)
    .then(response => {
        let data = JSON.parse(JSON.stringify(response.data.data))
        
        if (data.status == false) {
            // update clockInProgress var
            commit('setClock', false)

            // this.refresh()
        } else {
            // update startDateTime and clockInProgress var
            commit('setStart', data.time.replace('T', ' '))
            commit('setClock', true)
        }
    })
    .catch(error => {
        console.error(error)
    });
  },

  // // Refresh the workingtimes component
  // refresh({ commit, state }) {
  //   // refresh the workingtimes component
  // }
}

// mutations
const mutations = {
  //set the state.clockInProgress
  setClock (state, clock) {
    state.clockInProgress = clock
  },
  //set the state.startDateTime
  setStart (state, start) {
    state.startDateTime = start
  },

}

export default {
  // namespaced: true,
  state,
  getters,
  actions,
  mutations
}