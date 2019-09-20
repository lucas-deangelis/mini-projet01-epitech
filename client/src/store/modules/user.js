// initial state
const state = {
  user: {
    id: null,
    username: null,
    email: null
  },
  listUsers: []
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
  getListUsers: state => {
    return state.listUsers
  }
}

// actions
const actions = {
  // get user from the api and assign it to the state
  getUser({ commit, state }, id) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/users/' + id;
      
      // empty the user
      commit('setUser', {})
      
      window.axios.get(url)
      .then(response => {
        commit('setUser', JSON.parse(JSON.stringify(response.data.data)))
        resolve()
      })
      .catch(error => {
        console.error(error)
        reject(error)
      })
    })
  },

  // createUser({ commit, state }) {

  // },

  updateUser({ commit, state }, user) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/users/' + user.id;

      let params = {};
      for (const key in user) {
        if (user.hasOwnProperty(key)) {
          params[key] = user[key];
        }
      }

      window.axios.put(url, params)
      .then(response => {
          resolve()
      })
      .catch(error => {
          console.error(error)
          reject(error)
      })
    })
  },

  deleteUser({ commit, state }, user) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/users/' + user.id;

      window.axios.delete(url)
      .then(response => {
        resolve()
      })
      .catch(error => {
        console.error(error)
        reject(error)
      })
    })
  },

  getAllUsers({commit, state}) {
    let url = window.apiUrl + '/api/users/all';
      
    // empty the users list
    commit('setListUsers', [])
    
    window.axios.get(url)
    .then(response => {
      commit('setListUsers', JSON.parse(JSON.stringify(response.data.data)))
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
  // set the state.listUsers
  setListUsers (state, listUsers) {
    state.listUsers = listUsers
  }

}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}