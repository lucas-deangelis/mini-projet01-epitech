<template>
    <transition appear name="fade">
        <div id="workingtime" class="div-content">
            <div class="sub sub-header">
                <span><h2>Working Times</h2></span>
                <!-- <b-button variant="dark" v-b-modal.modal-add>ADD</b-button> -->
            </div>
            <div class="sub sub-content">
                <b-table sticky-header head-variant="light" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc"
        sort-icon-right :items="workingtimes" :fields="fields" show-empty id="workingtimes-table">
                    <!-- <template v-slot:cell(action)="row">
                        <b-button variant="primary" size="sm" @click="row.showDetails" class="mr-2" v-b-tooltip.hover title="Show">
                            <i class="fas fa-eye"></i>
                        </b-button>
                        <b-button variant="danger" size="sm" @click="row.delete" class="mr-2" v-b-tooltip.hover title="Delete">
                            <i class="fas fa-trash-alt"></i>
                        </b-button>
                    </template> -->
                    <template v-slot:empty="scope">
                        <h4>{{ scope.emptyText }}</h4>
                    </template>
                    <template v-slot:emptyfiltered="scope">
                        <h4>{{ scope.emptyFilteredText }}</h4>
                    </template>
                </b-table>
            </div>

            <b-modal id="modal-add" title="Add a working time">
                <p class="my-4">Hello from modal!</p>
            </b-modal>
        </div>
    </transition>
</template>



<script>
// This component defines many WorkingTimes.
import { mapState, mapActions } from 'vuex'

export default {
    name: 'WorkingTimes',

    data() {
        return {
            sortBy: 'end',
            sortDesc: true,
            fields: [
                { key: 'id', sortable: true },
                { key: 'start', sortable: true },
                { key: 'end', sortable: true },
                // { key: 'action', sortable: false }
            ],
        }
    },

    computed: {
        ...mapState('workingtime', {
            workingtimes: state => state.workingTimes
        }),
        ...mapState('user', {
            userId: state => state.user.id
        }),
    },

    mounted() {
        setTimeout(() => {
            this.$store.dispatch('getWorkingTimes', { userId: this.userId, start: '', end: '' });
        }, 1000);
    },

    methods: {
        
    }
}

</script>