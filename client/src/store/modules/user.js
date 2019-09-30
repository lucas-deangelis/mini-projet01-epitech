// initial state
const state = {
  user: {
    id: null,
    username: null,
    email: null,
    role: null
  },
  userStatus: {
    jwt: null,
    isAuthenticated: false
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
  },
  getUserStatus: state => {
    return state.userStatus
  },
  getJwt: state => {
    return state.userStatus.jwt;
  },
  getIsAuthenticated: state => {
    return state.userStatus.isAuthenticated
  },
  getUserRole: state => {
    return state.user.role
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
      
      window.axios({
        method: 'get',
        url: url,
        headers: { Authorization: "Bearer " + state.userStatus.jwt }
      })
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

  createUser({ commit, state }, params) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/users';


      let data = {
        user: {
          role: 'employee'
        }
      }
      for (const key in params) {
        if (params.hasOwnProperty(key)) {
          data.user[key] = params[key];
        }
      }


      window.axios({
        method: 'post',
        url: url,
        data: data,
        headers: { Authorization: "Bearer " + state.userStatus.jwt }
      })
      .then(response => {
          resolve()
      })
      .catch(error => {
          console.error(error)
          reject(error)
      })
    })
  },

  updateUser({ commit, state }, user) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/users/' + user.id;

      let params = {}
      for (const key in user) {
        if (user.hasOwnProperty(key)) {
          params[key] = user[key];
        }
      }

      window.axios({
        method: 'put',
        url: url,
        data: params,
        headers: { Authorization: "Bearer " + state.userStatus.jwt }
      })
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

  deleteUser({ commit, state }, user) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/users/' + user.id;

      window.axios({
        method: 'delete',
        url: url,
        headers: { Authorization: "Bearer " + state.userStatus.jwt }
      })
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
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/users/all';
        
      // empty the users list
      commit('setListUsers', [])
      
      window.axios({
        method: 'get',
        url: url,
        headers: { Authorization: "Bearer " + state.userStatus.jwt }
      })
      .then(response => {
        commit('setListUsers', JSON.parse(JSON.stringify(response.data.data)))
        resolve()
      })
      .catch(error => {
        console.error(error)
        reject(error)
      })
    })
  },

  /* Login */

  login({commit, dispatch, state}, user) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/sign_in';
      let params = {};

      for (const key in user) {
        if (user.hasOwnProperty(key)) {
          params[key] = user[key];
        }
      }

      window.axios.post(url, params)
      .then(response => {
        let data = response.data;

        if (data) {
          commit('setJwt', data.jwt);
          commit('setIsAuthenticated', true);
          dispatch('getAuthenticatedUser', data.jwt);
        }
        resolve();
      })
      .catch(error => {
        console.error(error)
        reject(error);
      })
    })
  },

  register({ commit, state }, params) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/register';


      let data = {
        user: {
          role: 'employee'
        }
      }
      for (const key in params) {
        if (params.hasOwnProperty(key)) {
          data.user[key] = params[key];
        }
      }

      window.axios.post(url, data)
      .then(response => {
          resolve()
      })
      .catch(error => {
          console.error(error)
          reject(error)
      })
    })
  },

  getAuthenticatedUser({commit, state}, jwt) {
    return new Promise((resolve, reject) => {
      let url = window.apiUrl + '/api/authenticated';
      let params = {
        headers: {
          Authorization: "Bearer " + jwt
        }
      }

      window.axios.get(url, params)
      .then(response => {
        let data = response.data;
        
        if (data) {
          commit('setUser', data);
        }
        resolve();
      })
      .catch(error => {
        commit('setJwt', null);
        commit('setIsAuthenticated', false);
        console.error(error);
        reject(error);
      })
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
  },
  setUserStatus (state, userStatus) {
    state.userStatus = userStatus
  },
  setJwt (state, jwt) {
    state.userStatus.jwt = jwt;
  },
  setIsAuthenticated (state, isAuthenticated) {
    state.userStatus.isAuthenticated = isAuthenticated;
  },
  setUserRole(state, userRole) {
    state.user.role = userRole
  }

}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}