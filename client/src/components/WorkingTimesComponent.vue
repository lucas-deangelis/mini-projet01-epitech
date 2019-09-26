<template>
    <div id="workingtime" class="div-content table-content">
        <div class="sub sub-header">
            <span><h2>Working Times</h2></span>
        </div>
        <div class="sub sub-content">
            <b-table responsive sticky-header outlined :sort-by.sync="sortBy" :sort-desc.sync="sortDesc"
    sort-icon-right :items="workingtimes" :fields="fields" show-empty id="workingtimes-table">
                <template v-slot:empty="scope">
                    <h4>{{ scope.emptyText }}</h4>
                </template>
                <template v-slot:emptyfiltered="scope">
                    <h4>{{ scope.emptyFilteredText }}</h4>
                </template>
            </b-table>
        </div>
    </div>
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
    }
}

</script>