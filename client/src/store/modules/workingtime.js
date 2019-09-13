// initial state
const state = {
  workingTimes: [],
  userId: 1
}

// getters
const getters = {

}

// actions
const actions = {
  getWorkingTimes ({ commit, state }, userId, start = '', end = '') {

    const savedWorkingTimes = [...state.workingTimes]
    // empty working times
    commit('setWorkingTimes', [])

    // get working times
    let url = window.apiUrl + '/api/workingtimes/' + userId + '?start=' + '' + '&end=' + '';  //+ this.$root.user.id;

    window.axios.get(url)
    .then(response => {
        // parse the data
        let workingTimesDatas = JSON.parse(JSON.stringify(response.data.data));
        let parsedWorkingTimes = [];

        for (const item of workingTimesDatas) {
            parsedWorkingTimes.push({
                'id': item.id,
                'start': item.start.replace('T', ' '),
                'end': item.end.replace('T', ' ')
            });
        }
        // assign the parsed datas to our state.workingtimes
        commit('setWorkingTimes', parsedWorkingTimes)
    })
    .catch(error => {
        console.error(error);
    });
  },

}

// mutations
const mutations = {
  //set the state.userId
  setUserId (state, userId) {
    state.userId = userId
  },

  // set the state.workingTimes
  setWorkingTimes (state, workingTimes) {
    state.workingTimes = workingTimes
  }
}

export default {
  // namespaced: true,
  state,
  getters,
  actions,
  mutations
}