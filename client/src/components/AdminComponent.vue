<template>
    <transition appear name="fade">
      <div id="main-content">

        <div id="users" class="div-content table-content">
            <div class="sub sub-header">
                <span><h2>Users</h2></span>
            </div>
            <div class="sub sub-content">
                <b-table sticky-header head-variant="light" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc"
        sort-icon-right :items="users" :fields="fields" show-empty id="users-table">
                    <template v-slot:cell(action)="row">
                      <template v-if="row.item.role == 'employee'">
                        <b-button variant="success" size="sm" @click="userPromote(row.item, row.index, $event.target)" class="mr-2" v-b-tooltip.hover title="Promote">
                            <i class="fas fa-hand-point-up"></i>
                        </b-button>
                      </template>
                      <template v-if="row.item.role == 'manager'">
                        <b-button variant="warning" size="sm" @click="userDemote(row.item, row.index, $event.target)" class="mr-2" v-b-tooltip.hover title="Demote">
                            <i class="fas fa-hand-point-down"></i>
                        </b-button>
                      </template>
                      <template v-if="row.item.id != userId">
                        <b-button variant="danger" size="sm" @click="userDelete(row.item, row.index, $event.target)" class="mr-2" v-b-tooltip.hover title="Delete">
                            <i class="fas fa-trash-alt"></i>
                        </b-button>
                      </template>
                    </template>
                    <template v-slot:empty="scope">
                        <h4>{{ scope.emptyText }}</h4>
                    </template>
                    <template v-slot:emptyfiltered="scope">
                        <h4>{{ scope.emptyFilteredText }}</h4>
                    </template>
                </b-table>
            </div>

            <!-- promote modal -->
            <b-modal :id="promoteModal.id" :title="promoteModal.title" hide-footer @hide="resetPromoteModal">
              <b-form @submit="onSubmitPromote">
                    <h3>{{ promoteModal.content }}</h3>
                    <b-button type="submit" variant="success">Yes promote this user</b-button>
                </b-form>
            </b-modal>
            <!-- demote modal -->
            <b-modal :id="demoteModal.id" :title="demoteModal.title" hide-footer @hide="resetDemoteModal">
              <b-form @submit="onSubmitDemote">
                    <h3>{{ demoteModal.content }}</h3>
                    <b-button type="submit" variant="warning">Yes demote this user</b-button>
                </b-form>
            </b-modal>
            <!-- delete user modal -->
            <b-modal :id="deleteModal.id" :title="deleteModal.title" hide-footer @hide="resetDeleteModal">
              <b-form @submit="onSubmitDelete">
                    <h3>{{ deleteModal.content }}</h3>
                    <b-button type="submit" variant="danger">Yes delete this user</b-button>
                </b-form>
            </b-modal>
        </div>
      </div>
    </transition>
</template>



<script>
// This component defines many WorkingTimes.
import { mapGetters, mapState } from 'vuex'

export default {
    name: 'Admin',

    data() {
        return {
            sortBy: 'id',
            sortDesc: false,
            fields: [
                { key: 'id', sortable: true },
                { key: 'email', sortable: true },
                { key: 'username', sortable: true },
                { key: 'role', sortable: true },
                { key: 'action', sortable: false }
            ],
            promoteModal: {
              id: 'promote-modal',
              title: 'Promote an user',
              content: '',
              userId : null
            },
            demoteModal: {
              id: 'demote-modal',
              title: 'Demote an user',
              content: '',
              userId : null
            },
            deleteModal: {
              id: 'delete-modal',
              title: 'Delete an user',
              content: '',
              userId : null
            }
        }
    },

    computed: {
      ...mapGetters({
          users: 'user/getListUsers',
          userId: 'user/getUserId'
      })
    },

    mounted() {

    },

    methods: {

      // methods for promote modal
      userPromote(item, index, button) {
        let rowUser = JSON.parse(JSON.stringify(item))
        this.promoteModal.content = 'Are you sure you want to promote ' + rowUser.username + ' - ' + rowUser.email + ' ?'
        this.promoteModal.userId = rowUser.id
        this.$root.$emit('bv::show::modal', this.promoteModal.id, button)
      },
      resetPromoteModal() {
        this.promoteModal.content = ''
        this.promoteModal.userId = null
      },
      onSubmitPromote(evt) {
          evt.preventDefault()
          this.$store.dispatch('user/updateUser', { id: this.promoteModal.userId, role: 'manager' })

          // close the modal
          this.resetPromoteModal()
          this.$root.$emit('bv::hide::modal', this.promoteModal.id)
      },
      // methods for demote modal
      userDemote(item, index, button) {
        let rowUser = JSON.parse(JSON.stringify(item))
        this.demoteModal.content = 'Are you sure you want to demote ' + rowUser.username + ' - ' + rowUser.email + ' ?'
        this.demoteModal.userId = rowUser.id
        this.$root.$emit('bv::show::modal', this.demoteModal.id, button)
      },
      resetDemoteModal() {
        this.demoteModal.content = ''
        this.demoteModal.userId = null
      },
      onSubmitDemote(evt) {
          evt.preventDefault()
          this.$store.dispatch('user/updateUser', { id: this.demoteModal.userId, role: 'employee' })

          // close the modal
          this.resetDemoteModal()
          this.$root.$emit('bv::hide::modal', this.demoteModal.id)
      },
      // methods for delete modal
      userDelete(item, index, button) {
        let rowUser = JSON.parse(JSON.stringify(item))
        this.deleteModal.content = 'Are you sure you want to delete ' + rowUser.username + ' - ' + rowUser.email + ' ?'
        this.deleteModal.userId = rowUser.id
        this.$root.$emit('bv::show::modal', this.deleteModal.id, button)
      },
      resetDeleteModal() {
        this.deleteModal.content = ''
        this.deleteModal.userId = null
      },
      onSubmitDelete(evt) {
          evt.preventDefault()
          this.$store.dispatch('user/deleteUser', { id: this.deleteModal.userId })

          // close the modal
          this.resetDeleteModal()
          this.$root.$emit('bv::hide::modal', this.deleteModal.id)
      },
    }
}

</script>