<template>
    <transition appear name="fade">
        <div id="users" class="div-content">
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
                        <b-button variant="warning" size="sm" v-b-modal.modal-demote-user class="mr-2" v-b-tooltip.hover title="Demote">
                            <i class="fas fa-hand-point-down"></i>
                        </b-button>
                      </template>
                      <template v-if="row.item.id != userId">
                        <b-button variant="danger" size="sm" v-b-modal.modal-delete-user class="mr-2" v-b-tooltip.hover title="Delete">
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

            <!-- Info modal -->
            <b-modal :id="promoteModal.id" :title="promoteModal.title" hide-footer @hide="resetPromoteModal">
              <b-form @submit="onSubmitPromote">
                    <h3>{{ promoteModal.content }}</h3>
                    <b-button type="submit" variant="success">Yes promote this user</b-button>
                </b-form>
            </b-modal>

            <b-modal id="modal-demote-user" title="Demote user">
                <p class="my-4">Are you sure you want to demote this user ?</p>
            </b-modal>

            <b-modal id="modal-delete-user" title="Delete user">
                <p class="my-4">Are you sure you want to delete this user ?</p>
            </b-modal>
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
            sortBy: 'end',
            sortDesc: true,
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
            }
        }
    },

    computed: {
      ...mapGetters({
          users: 'user/getListUsers'
      }),
      ...mapState('user', {
          userId: state => state.user.id
      }),
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
          this.$store.dispatch('user/updateUser', { userId: this.promoteModal.userId, role: 'manager' })

          // close the modal
          this.$root.$emit('bv::hide::modal', this.promoteModal.id)
      },
    }
}

</script>