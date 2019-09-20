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
  clock({ commit, state, dispatch }, userId) {
    let url = window.apiUrl + '/api/clocks/' + userId

    window.axios.post(url)
    .then(response => {
        let data = JSON.parse(JSON.stringify(response.data.data))
        console.log(data)
        
        if (data.status == false) {
          // update startDateTime and clockInProgress var
          commit('setStart', data.time.replace('T', ' '))
          commit('setClock', true)
          
        } else {
          // update clockInProgress var
          commit('setStart', null)
          commit('setClock', false)
        }
          dispatch('refresh', userId)
    })
    .catch(error => {
        console.error(error)
    });
  },

  get({commit, state, dispatch}, userId) {
    let url = window.apiUrl + '/api/clocks/' + userId

    window.axios.get(url)
    .then(response => {
        let data = JSON.parse(JSON.stringify(response.data.data))
        console.log(data)

        if (data.status == false) {
            // update clockInProgress var
            commit('setClock', false)
        } else {
            // update startDateTime and clockInProgress var
            commit('setClock', true)
          }
          commit('setStart', data.time.replace('T', ' '))
    })
    .catch(error => {
        console.error(error)
    })
  },

  // Refresh the workingtimes component
  refresh({ dispatch, commit, state }, userId) {
    // refresh the workingtimes component
    // call working time action to get action
    dispatch('getWorkingTimes', { userId: userId, start: '', end: '' }, {root:true})
    
  }
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
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}