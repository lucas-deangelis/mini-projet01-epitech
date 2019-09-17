// initial state
const state = {
  workingTimes: [],
  received: false
}

// getters
const getters = {
  // parse state.workingTimes to adapt it for the line chart in chartmanagercomponent
  getWK: state => {
    return state.workingTimes
  }
}

// actions
const actions = {
  getWorkingTimes: { 
    root: true,
    handler ({ commit, state }, params) {

      const savedWorkingTimes = [...state.workingTimes]
      // empty working times
      commit('setWorkingTimes', [])
      commit('setReceived', false)

      // get working times
      let url = window.apiUrl + '/api/workingtimes/' + params.userId + '?start=' + '' + '&end=' + ''  //+ this.$root.user.id;

      window.axios.get(url)
      .then(response => {
          // parse the data
          let workingTimesDatas = JSON.parse(JSON.stringify(response.data.data))
          let parsedWorkingTimes = []

          for (const item of workingTimesDatas) {
              parsedWorkingTimes.push({
                  'id': item.id,
                  'start': item.start.replace('T', ' '),
                  'end': item.end.replace('T', ' ')
              })
          }
          // assign the parsed datas to our state.workingtimes
          commit('setWorkingTimes', parsedWorkingTimes)
          commit('setReceived', true)
          return parsedWorkingTimes
      })
      .catch(error => {
          console.error(error)
          return []
      });
    }
  },

}

// mutations
const mutations = {

  // set the state.workingTimes
  setWorkingTimes (state, workingTimes) {
    state.workingTimes = workingTimes
  },

  setReceived (state, received) {
    state.received = received
  }

}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}