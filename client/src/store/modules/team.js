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
    getManagerTeams({commit, state, rootState }, managerId){
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/users/' + managerId + '/teams';

            // empty the teams list
            commit('setListTeams', [])
            
            window.axios({
                method: 'get',
                url: url,
                headers: { Authorization: "Bearer " + rootState.user.userStatus.jwt }
            })
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

    createTeam({ commit, state, rootState }, team){
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/users/' + team.managerId + '/teams/'

            window.axios({
                method: 'post',
                url: url,
                data: {
                    name: team.name
                },
                headers: { Authorization: "Bearer " + rootState.user.userStatus.jwt }
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
    updateTeam({ commit, state, rootState }, team){
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + team.id;

            let params = {};
            for(const key in team){
                if(user.hasOwnPropoerty(key)){
                    params[key] = team[key];
                }
            }

            window.axios({
                method: 'put',
                url: url,
                data: params,
                headers: { Authorization: "Bearer " + rootState.user.userStatus.jwt }
            })
            .then(response => {
                resolve()
            })
            .cath(error => {
                console.error(error)
                reject(error)
            })
        })
    },

    deleteTeam({commit, state, rootState }, team) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + team.id;

            window.axios({
                method: 'delete',
                url: url,
                data: params,
                headers: { Authorization: "Bearer " + rootState.user.userStatus.jwt }
            })
            .then(response => {
                resolve()
            })
            .cath(error => {
                console.error(error)
                reject(error)
            })
        })
    },

    getAllTeams({commit, state, rootState }) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams';

            // empty the teams list
            commit('setListTeams', [])
            
            window.axios({
                method: 'get',
                url: url,
                headers: { Authorization: "Bearer " + rootState.user.userStatus.jwt }
            })
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

    removeUserFromTeam({commit, state, rootState }, item) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + item.teamId + '/users/' + item.userId

            window.axios({
                method: 'delete',
                url: url,
                headers: { Authorization: "Bearer " + rootState.user.userStatus.jwt }
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

    addUserInTeam({commit, state, rootState }, item) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + item.teamId + '/users/' + item.userId

            window.axios({
                method: 'post',
                url: url,
                headers: { Authorization: "Bearer " + rootState.user.userStatus.jwt }
            })
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