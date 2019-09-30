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
                <b-form-group
                  :state="nameState"
                  label="Name"
                  label-for="name-input"
                  invalid-feedback="Name is required"
                >
                  <b-form-input
                    id="name-input"
                    v-model="name"
                    :state="nameState"
                    required
                  ></b-form-input>
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
                                <b-button variant="danger" size="sm" @click="deleteUserFromTeam(user.id, row.item.id, $event.target)" v-b-tooltip.hover title="Delete">
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
          <b-form @submit="onSubmitDelete">
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
                { key: 'manager_id', sortable: false},
                { key: 'action', sortable: false}
            ],
            deleteUserFromTeamModal: {
              id: 'delete-user-from-team-modal',
              title: 'Delete an member from the team',
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
    })
  },

  mounted() {
      this.$store.dispatch('team/getManagerTeams', this.user.id)
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
        this.nameState = valid ? 'valid' : 'invalid'
        return valid
      },
      resetModal() {
        this.name = ''
        this.nameState = null
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
    deleteUserFromTeam(userId, teamId, button) {
      /*let rowUser = JSON.parse(JSON.stringify(item))
      this.deleteModal.content = 'Are you sure you want to remove ' + rowUser.username + ' - ' + rowUser.email + ' from the team ?'
      this.deleteModal.teamId = rowTeam.id
      this.deleteModal.userId = rowUser.id
      this.$root.$emit('bv::show::modal', this.deleteModal.id, button)*/
      console.log(userId)
      console.log(teamId)
    },
    resetDeleteUserTeamModal() {
      /*this.deleteModal.content = ''
      this.deleteModal.userId = null*/
    },
    onSubmitDeleteUserTeam(evt) {
        /*evt.preventDefault()
        this.$store.dispatch('user/deleteUser', { id: this.deleteModal.userId })

        // close the modal
        this.resetDeleteModal()
        this.$root.$emit('bv::hide::modal', this.deleteModal.id)*/
    }
  }

}
</script>


<!--Style-->
<style>

</style>