// initial state
const state = {
  user: {
    id: null,
    username: null,
    email: null
  }
}

// getters
const getters = { 
  getUserId: state => {
    return state.user.id
  },
  getUserUsername: state => {
    return state.user.username
  },
  getUserEmail: state => {
    return state.user.email
  },
}

// actions
const actions = {
  // get user from the api and assign it to the state
  getUser({ commit, state }, userId) {
    let url = window.apiUrl + '/api/users/' + userId;

    // empty the user
    commit('setUser', {})
    
    window.axios.get(url)
    .then(response => {
        commit('setUser', JSON.parse(JSON.stringify(response.data.data)))
    })
    .catch(error => {
        console.error(error)
    })
  },

  // createUser({ commit, state }) {

  // },

  updateUser({ commit, state }, user) {
    let url = window.apiUrl + '/api/users/' + user.userId;

    window.axios.put(url, {
      email: user.email,
      username: user.username
    })
    .then(response => {
        commit('setUser', JSON.parse(JSON.stringify(response.data.data)))
    })
    .catch(error => {
        console.error(error)
    })
  },

  deleteUser({ commit, state }, user) {
    let url = window.apiUrl + '/api/users/' + user.userId;

    window.axios.delete(url)
    .then(response => {
        commit('setUser', {
          id: null,
          username: null,
          email: null
        })
    })
    .catch(error => {
        console.error(error)
    })
  }
}

// mutations
const mutations = {
  //set the state.user.id
  setUserId (state, userId) {
    state.user.id = userId
  },
  //set the state.user.username
  setUserUsername (state, userUsername) {
    state.user.username = userUsername
  },
  //set the state.user.email
  setUserEmail (state, userEmail) {
    state.user.email = userEmail
  },
  //set the state.user
  setUser (state, user) {
    state.user = user
  },

}

export default {
  // namespaced: true,
  state,
  getters,
  actions,
  mutations
}