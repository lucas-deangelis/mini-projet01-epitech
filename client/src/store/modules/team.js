//initial state
const state = {
    listTeams: []
}

//getters
const getters = {
    getTeams: state => {
        return state.listTeams
    }
}

// actions
const actions = {
    getManagerTeams({commit, state}, managerId){
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/users/' + managerId + '/teams';

            // empty the teams list
            commit('setListTeams', [])
            
            window.axios.get(url)
            .then(response => {
                commit('setListTeams', JSON.parse(JSON.stringify(response.data.data)))
                resolve()
            })
            .catch(error => {
                console.error(error)
                reject(error)
            })

        })
    },

    createTeam({ commit, state}, team){
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/users/' + team.managerId + '/teams/'

            window.axios.post(url, {
                name: team.name
            })
            .then(response => {
                // add team to list team
                let newTeam = JSON.parse(JSON.stringify(response.data.data))
                newTeam.users = []
                commit('addTeam', newTeam)
                resolve()
            })
            .catch(error => {
                console.error(error) 
                reject(error)
            })
        })
    },

    // update a team
    updateTeam({ commit, state }, team){
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + team.id;

            let params = {};
            for(const key in team){
                if(user.hasOwnPropoerty(key)){
                    params[key] = team[key];
                }
            }

            window.axios.put(url, params)
            .then(response => {
                resolve()
            })
            .cath(error => {
                console.error(error)
                reject(error)
            })
        })
    },

    deleteTeam({commit, state}, team) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + team.id;

            window.axios.delete(url, params)
            .then(response => {
                resolve()
            })
            .cath(error => {
                console.error(error)
                reject(error)
            })
        })
    },

    getAllTeams({commit, state}) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams';

            // empty the teams list
            commit('setListTeams', [])
            
            window.axios.get(url)
            .then(response => {
                commit('setListTeams', JSON.parse(JSON.stringify(response.data.data)))
                resolve()
            })
            .catch(error => {
                console.error(error)
                reject(error)
            })
        })
    },

    removeUserFromTeam({commit, state}, item) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + item.teamId + '/users/' + item.userId

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

    addUserInTeam({commit, state}, item) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + item.teamId + '/users/' + item.userId

            window.axios.post(url)
            .then(response => {
                resolve()
            })
            .catch(error => {
                console.error(error)
                reject(error)
            })
        })
    }

}

// mutations
const mutations = {
    addTeam(state, team) {
        state.listTeams.push(team)
    },
    setListTeams(state, listTeams) {
        state.listTeams = listTeams
    }
}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
  }