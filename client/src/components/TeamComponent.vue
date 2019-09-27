<!-- Template -->

<template>
    <transition appear name="fade">
      <div id="main-content">
        <div id="teams" class="div-content table-content">
            <div class="sub sub-header">
                <span><h2>Teams</h2> <b-button>Test</b-button> </span>
            </div>
            <div class="sub sub-content">

                <!-- Tableau des teams -->
                <div class="sub sub-content">
                    <b-table responsive sticky-header head-variant="light" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc"
                      sort-icon-right :items="teams" :fields="teamsFields" show-empty id="teams-table">

                        <!-- Gère actions sur la ligne -->
                        <template v-slot:cell(show_details)="row">
                            <b-button size="sm" @click="row.toggleDetails" class="mr-2">
                              {{ row.detailsShowing ? 'Hide' : 'Show'}} members
                            </b-button>
                        </template>

                        <template v-slot:cell(action)="row"> 
                          <b-button variant="success" size="sm">
                            <i class="fas fa-pen"></i>
                          </b-button>
                          <b-button variant="danger" size="sm" @click="teamDelete(row.item, row.index, $event.target)" class="mr-2" v-b-tooltip.hover title="Delete">
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
                                <b-button variant="danger" size="sm" @click="userDelete(row.item, row.index, $event.target)" class="mr-2" v-b-tooltip.hover title="Delete">
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
        <b-modal :id="deleteModal.id" :title="deleteModal.title" hide-footer @hide="resetDeleteModal">
          <b-form @submit="onSubmitDelete">
                <h3>{{ deleteModal.content }}</h3>
                <b-button type="submit" variant="danger">Yes delete this member from the team</b-button>
            </b-form>
        </b-modal>

      </div>
    </transition>
</template>


<!-- Script -->
<script>

import { mapGetters, mapState } from 'vuex';

export default {
  name: 'Team',

  data() {
        return {
            sortBy: 'id',
            sortDesc: false,
            teamsFields: [
                { key: 'id', sortable: true },
                { key: 'name', sortable: true },
                { key: 'show_details', sortable: false},
                { key: 'action', sortable: false}
            ],
            deleteModal: {
              id: 'delete-modal',
              title: 'Delete an member from the team',
              content: '',
              teamId: null,
              userId : null
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
    // methods for delete modal
    userDelete(item, index, button) {
      let rowUser = JSON.parse(JSON.stringify(item))
      this.deleteModal.content = 'Are you sure you want to remove ' + rowUser.username + ' - ' + rowUser.email + ' from the team ?'
      this.deleteModal.teamId = rowTeam.id
      this.deleteModal.userId = rowUser.id
      this.$root.$emit('bv::show::modal', this.deleteModal.id, button)
    },
    resetDeleteModal() {
      this.deleteModal.content = ''
      this.deleteModal.userId = null
    },
    onSubmitDelete(evt) {
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