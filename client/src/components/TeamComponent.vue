<!-- Template -->

<template>
    <transition appear name="fade">
      <div id="main-content">
        <div id="teams" class="div-content table-content">
            <div class="sub sub-header" id="main">
                <span>
                  <h2 class="d-inline-block">Teams</h2> 
                  <b-button class="ml-5 mb-2" v-b-modal.modal-choose-teamname v-b-tooltip.hover title="Create team" variant="success">
                    <i class="fas fa-plus-square"></i>
                  </b-button> 
                </span>
            </div>

            <b-modal
              id="modal-choose-teamname"
              ref="modal"
              title="Submit Your Name"
              @show="resetModal"
              @hidden="resetModal"
              @ok="handleOk"
            >
              <form ref="form" @submit.stop.prevent="handleSubmit">
                <b-form-group label="Name" label-for="name-input">
                  <b-form-input id="name-input" v-model="name" required></b-form-input>
                  <b-form-invalid-feedback :state="validationName">
                    Name is required
                  </b-form-invalid-feedback>
                  <b-form-valid-feedback :state="validationName">
                    Sweet !
                  </b-form-valid-feedback>
                </b-form-group>
              </form>
            </b-modal>

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
                          <b-button variant="success" size="sm" class="mr-1">
                            <i class="fas fa-pen"></i>
                          </b-button>
                          <b-button variant="success" size="sm" class="mr-5">
                            <i class="fas fa-user-plus"></i>
                          </b-button>
                          <b-button variant="danger" size="sm" @click="teamDelete(row.item, row.index, $event.target)" v-b-tooltip.hover title="Delete">
                            <i class="fas fa-trash-alt"></i>
                          </b-button>
                        </template>

                        <template v-slot:row-details="row">
                          <b-card v-for="user in row.item.users" :key="user.id">
                            <b-row class="mb-2">
                              <b-col sm="3">Name : {{user.username}} </b-col>
                              <b-col sm="3">Email : {{ user.email }}</b-col>
                              <b-col sm="3">Role : {{ user.role }}</b-col>
                              <b-col sm="3">
                                <b-button variant="danger" size="sm" @click="deleteUserFromTeam(row.index, row.item, user, $event.target)" v-b-tooltip.hover title="Delete">
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

        <!-- delete user modal -->
        <b-modal :id="deleteUserFromTeamModal.id" :title="deleteUserFromTeamModal.title" hide-footer @hide="resetDeleteUserTeamModal">
          <b-form @submit="onSubmitDeleteUserTeam">
                <h3>{{ deleteUserFromTeamModal.content }}</h3>
                <b-button type="submit" variant="danger">Yes delete this member from the team</b-button>
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
            namteState: null,
            teamsFields: [
                { key: 'id', sortable: true },
                { key: 'name', sortable: true },
                { key: 'show_details', sortable: false},
                { key: 'action', sortable: false}
            ],
            deleteUserFromTeamModal: {
              id: 'delete-user-from-team-modal',
              title: 'Delete a member from the team',
              content: '',
              teamId: null,
              userId : null
            },
            createTeamModel: {
              id:'create-team',
              title: 'Create a team',
              content: '',
              name: ''
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

  components: {
      
  },

  methods: {
    // methods to create a new team
    createTeam(teamname, button){
      console.log("Team name :" + this.name)
      this.$store.dispatch('team/createTeam', { managerId: this.user.id, teamName: this.name})
    },

    checkFormValidity() {
        const valid = this.$refs.form.checkValidity()
        return valid
      },
      resetModal() {
        this.name = ''
      },
      handleOk(bvModalEvt) {
        // Prevent modal from closing
        bvModalEvt.preventDefault()
        // Trigger submit handler
        this.handleSubmit()
        this.createTeam(this.name)
      },
      handleSubmit() {
        // Exit when the form isn't valid
        if (!this.checkFormValidity()) {
          return
        }
        // Hide the modal manually
        this.$nextTick(() => {
          this.$refs.modal.hide()
        })
      },

    // methods to delate a team
    teamDelete(item, index, button){
      console.log(item)
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
          console.log('done')
          // commit the teams updated
          this.$store.commit('team/setListTeams', teams)
        })

        // close the modal
        this.resetDeleteUserTeamModal()
        this.$root.$emit('bv::hide::modal', this.deleteUserFromTeamModal.id)
    }
  }

}
</script>


<!--Style-->
<style>

</style>