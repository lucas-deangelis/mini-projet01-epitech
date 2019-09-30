//initial state
const state = {
    team: {
        id: null,
        name: null
    },
    membersList: [],
    listTeams: []
}

//getters
const getters = {
    getTeamId: state => {
        return state.team.id
    },

    getTeamName: state => {
      return state.team.name  
    },

    getTeamMembers: state => {
        return state.membersList  
      },

    getTeams: state => {
        return state.listTeams
    }
}

// actions
const actions = {
    // get a team from the api and assign it to the state
    getTeam({commit, state}, managerId, teamId){
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/users/' + managerId + '/teams/' + teamId;

            //empty the team
            commit('setTeam', {});

            windows.axios.get(url)
            .then(response => {
                commit('setTeam', JSON.parse(JSON.stringify(response.data.data)))
                resolve()
            })
            .catch(error => {
                console.error(error)
                reject(error)
            })
        })
    },

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

    createTeam({ commit, state}, managerId, teamName){

        let url = window.apiUrl + '/api/users/' + managerId + '/teams/'

        var text = '{ "team": { "name": "'+teamName+'" } }'
        var obj = JSON.parse(text)

        console.log(text)

        window.axios.post(url, obj)
        .then(response => {resolve()
        })
        .catch(error => {
            console.error(error) 
            reject(error)
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
                commit('setListTeams', JSON.parse(JSON.stringify(res226ponse.data.data)))
                resolve()
            })
            .catch(error => {
                console.error(error)
                reject(error)
            })
        })
    },

    getTeamMembers({commit, state}, teamId) {
        return new Promise((resolve, reject) => {
            let url = window.apiUrl + '/api/teams/' + teamId + '/getMembers'

            //empty the members list
            commit('setTeamMembers', [])

            window.axios.get(url)
            .then(response => {
                commit('setTeamMembers', JSON.parse(JSON.stringify(response.data.data)))
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

    setTeamId(state, teamId) {
        state.team.id = teamId
    },

    setTeamName(state, teamName) {
        state.team.name = teamName
    },

    setTeam(state, team){
        state.team = team
    },

    setTeamMembers(state, users){
        state.membersList = users
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