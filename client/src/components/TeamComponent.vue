<!-- Template -->

<template>
    <transition appear name="fade">
      <div id="main-content">
        <div id="teams" class="div-content table-content">
            <div class="sub sub-header" id="main">
                <span>
                  <h2 class="d-inline-block">Teams</h2> 
                  <b-button class="ml-5 mb-2" v-b-modal.modal-create-team v-b-tooltip.hover title="Create a team" variant="success">
                    <i class="fas fa-plus-square"></i>
                  </b-button> 
                </span>
            </div>

            <div class="sub sub-content">

                <!-- Tableau des teams -->
                <div class="sub sub-content">
                    <b-table responsive sticky-header head-variant="light" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc"
                      sort-icon-right :items="teams" :fields="teamsFields" show-empty id="teams-table">

                        <!-- Gère actions sur la ligne -->
                        <template v-slot:cell(show_details)="row">
                            <b-button size="sm" @click="row.toggleDetails">
                              {{ row.detailsShowing ? 'Hide' : 'Show'}} members
                            </b-button>
                        </template>

                        <template v-slot:cell(action)="row"> 
                          <!-- <b-button variant="success" size="sm" class="mr-1">
                            <i class="fas fa-pen"></i>
                          </b-button> -->
                          <b-button variant="success" size="sm" class="mr-2" @click="addUserInTeam(row.index, row.item, user, $event.target)" v-b-tooltip.hover title="Add an user">
                            <i class="fas fa-user-plus"></i>
                          </b-button>
                          <!-- <b-button variant="danger" size="sm" @click="teamDelete(row.item, row.index, $event.target)" v-b-tooltip.hover title="Delete ">
                            <i class="fas fa-trash-alt"></i>
                          </b-button> -->
                        </template>

                        <template v-slot:row-details="row">
                          <b-card v-for="user in row.item.users" :key="user.id">
                            <b-row class="mb-2">
                              <b-col sm="3">Name : {{user.username}} </b-col>
                              <b-col sm="3">Email : {{ user.email }}</b-col>
                              <b-col sm="3">Role : {{ user.role }}</b-col>
                              <b-col sm="3">
                                <b-button variant="danger" size="sm" @click="deleteUserFromTeam(row.index, row.item, user, $event.target)" v-b-tooltip.hover title="Remove this user">
                                  <i class="fas fa-trash-alt"></i>
                                </b-button>
                              </b-col>
                            </b-row>
                          </b-card>
                        </template>

                        <!-- info if no data -->
                        <template v-slot:empty="scope">
                            <h4>{{ scope.emptyText }}</h4>
                        </template>
                        <template v-slot:emptyfiltered="scope">
                          <h4>{{ scope.emptyFilteredText }}</h4>
                        </template>
                    </b-table>
                </div>

            </div>
        </div>

        <b-modal id="modal-create-team" hide-footer title="Create a new team" @hide="resetCreateTeamModal">
          <form ref="form" @submit="onSubmitCreateTeam">
            <b-form-group label="Name" label-for="name-input">
              <b-form-input id="name-input" v-model="name" required></b-form-input>
              <b-form-invalid-feedback :state="validationName">
                Name is required
              </b-form-invalid-feedback>
              <b-form-valid-feedback :state="validationName">
                Sweet !
              </b-form-valid-feedback>
            </b-form-group>
            <b-button type="submit" variant="success">Yes create this team</b-button>
          </form>
        </b-modal>

        <!-- delete user modal -->
        <b-modal :id="deleteUserFromTeamModal.id" :title="deleteUserFromTeamModal.title" hide-footer @hide="resetDeleteUserTeamModal">
          <b-form @submit="onSubmitDeleteUserTeam">
            <h3>{{ deleteUserFromTeamModal.content }}</h3>
            <b-button type="submit" variant="danger">Yes delete this member from this team</b-button>
          </b-form>
        </b-modal>
        <!-- add user in teammodal -->
        <b-modal :id="addUserInTeamModal.id" :title="addUserInTeamModal.title" hide-footer @hide="resetAddUserTeamModal">
          <b-form @submit="onSubmitAddUserTeam">
            <h3>{{ addUserInTeamModal.content }}</h3>
            <b-form-select class="mb-5" v-model="addUserInTeamModal.userInTeamSelected" :options="addUserInTeamModal.usersNotInThisTeam"></b-form-select>
            <b-button type="submit" variant="success">Yes add this member in this team</b-button>
          </b-form>
        </b-modal>

      </div>
    </transition>
</template>


<!-- Script -->
<script>

import { mapGetters, mapState, mapActions } from 'vuex';

export default {
  name: 'Team',

  data() {
        return {
            sortBy: 'id',
            sortDesc: false,
            name: '',
            usersNotInThisTeam: [],
            userInTeamSelected: null,
            teamsFields: [
                { key: 'id', sortable: true },
                { key: 'name', sortable: true },
                { key: 'show_details', sortable: false},
                { key: 'action', sortable: false}
            ],
            deleteUserFromTeamModal: {
              id: 'delete-user-from-team-modal',
              title: 'Remove a member from this team',
              content: '',
              teamId: null,
              userId : null
            },
            addUserInTeamModal: {
              id: 'add-user-in-team-modal',
              title: 'Add a user in this team',
              content: '',
              teamId: null,
              usersNotInThisTeam: [],
              userInTeamSelected: null,
            }
        }
  },
  
  computed:{
    ...mapState('user', {
      user: state => state.user
    }),

    ...mapGetters({
        teams: 'team/getTeams',
        users: 'user/getListUsers'
    }),

    validationName() {
      return this.name != null && this.name != '' && this.name.length > 0
    }
  },

  mounted() {
      setTimeout(() => {
        this.$store.dispatch('team/getManagerTeams', this.user.id)
      }, 1000);
  },

  methods: {
    // methods for create team modal
    resetCreateTeamModal() {
      this.name = ''
    },
    onSubmitCreateTeam(evt) {
        evt.preventDefault()

        this.$store.dispatch('team/createTeam', {
          managerId: this.user.id,
          name: this.name
        }).then(() => {

        })

        // close the modal
        this.resetCreateTeamModal()
        this.$root.$emit('bv::hide::modal', 'modal-create-team')
    },
    // methods for delete modal
    deleteUserFromTeam(index, item, user, button) {
      let team = JSON.parse(JSON.stringify(item))
      this.deleteUserFromTeamModal.content = 'Are you sure you want to remove ' + user.username + ' - ' + user.email + ' from the team ?'
      this.deleteUserFromTeamModal.teamId = team.id
      this.deleteUserFromTeamModal.userId = user.id
      this.$root.$emit('bv::show::modal', this.deleteUserFromTeamModal.id, button)
    },
    resetDeleteUserTeamModal() {
      this.deleteUserFromTeamModal.content = ''
      this.deleteUserFromTeamModal.teamId = null
      this.deleteUserFromTeamModal.userId = null
    },
    onSubmitDeleteUserTeam(evt) {
        evt.preventDefault()
        let teams = this.teams
        // update the team and remove the user
        let teamIndex = teams.findIndex((item) => {
          return item.id === this.deleteUserFromTeamModal.teamId
        })
        teams[teamIndex].users = teams[teamIndex].users.filter((item) => {
          return item.id != this.deleteUserFromTeamModal.userId
        })

        this.$store.dispatch('team/removeUserFromTeam', {
          teamId: this.deleteUserFromTeamModal.teamId,
          userId: this.deleteUserFromTeamModal.userId
        }).then(() => {
          // commit the teams updated
          this.$store.commit('team/setListTeams', teams)
        })

        // close the modal
        this.resetDeleteUserTeamModal()
        this.$root.$emit('bv::hide::modal', this.deleteUserFromTeamModal.id)
    },
    // methods for add user in team modal
    addUserInTeam(index, item, user, button) {
      let team = JSON.parse(JSON.stringify(item))
      this.addUserInTeamModal.content = 'Please select the user you want to add in this team ?'
      this.addUserInTeamModal.teamId = team.id

      // get the users that are not already in this team
      let users = this.users
      let usersInId = team.users.map(item => {
        return item.id
      })
      let usersNotInId = users.filter((item) => {
        return !usersInId.includes(item.id) && item.id != this.user.id
      })

      usersNotInId.forEach(user => {
        this.addUserInTeamModal.usersNotInThisTeam.push({
          value: user.id,
          text: user.username + ' - ' + user.email
        })
      });
      this.addUserInTeamModal.usersNotInThisTeam.sort((a, b) => {
        if (a.text > b.text)
          return 1
        else if (a.text < b.text)
          return -1
        else return 0
      })


      this.$root.$emit('bv::show::modal', this.addUserInTeamModal.id, button)
    },
    resetAddUserTeamModal() {
      this.addUserInTeamModal.content = ''
      this.addUserInTeamModal.teamId = null
      this.addUserInTeamModal.userInTeamSelected = null
      this.addUserInTeamModal.usersNotInThisTeam = []
    },
    onSubmitAddUserTeam(evt) {
        evt.preventDefault()
        // get the selected user
        let users = this.users
        let userIndex = this.addUserInTeamModal.usersNotInThisTeam.findIndex((item) => {
          return item.value == this.addUserInTeamModal.userInTeamSelected
        })
        let teams = this.teams
        let userId = this.addUserInTeamModal.usersNotInThisTeam[userIndex].value
        let user = users.find((item) => {
          return item.id === userId
        })

        // update the team and add the user
        let teamIndex = teams.findIndex((item) => {
          return item.id === this.addUserInTeamModal.teamId
        })
        teams[teamIndex].users.push(user)

        this.$store.dispatch('team/addUserInTeam', {
          teamId: this.addUserInTeamModal.teamId,
          userId: userId
        }).then(() => {
          // commit the teams updated
          this.$store.commit('team/setListTeams', teams)
        })

        // close the modal
        this.resetAddUserTeamModal()
        this.$root.$emit('bv::hide::modal', this.addUserInTeamModal.id)
    }
  }

}
</script>