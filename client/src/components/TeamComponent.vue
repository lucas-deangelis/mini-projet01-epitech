<!-- Template -->

<template>
    <transition appear name="fade">
      <div id="main-content">
        <div id="teams" class="div-content table-content">
            <div class="sub sub-header">
                <span><h2>Teams</h2></span>
            </div>
            <div class="sub sub-content">
                <!-- <b-table sticky-header head-variant="light" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc"
        sort-icon-right :items="users" :fields="fields" show-empty id="users-table"> -->
                <b-table sticky-header head-variant="light" show-empty id="teams-table">
                    <template v-slot:empty="scope">
                        <h4>{{ scope.emptyText }}</h4>
                    </template>
                    <template v-slot:emptyfiltered="scope">
                        <h4>{{ scope.emptyFilteredText }}</h4>
                    </template>
                </b-table>
            </div>
        </div>
        <p>Role de l'utilisateuuuuuuuuuuuuuuuuuuur : {{userRole}}</p>
      </div>
    </transition>

    <!-- <b-button v-if="userIsManagerOrAdmin">Créer une team</b-button> -->
    
</template>


<!-- Script -->
<script>

import { mapGetters, mapState, mapActions } from 'vuex';

export default {
  name: 'Team',
  
  computed:{
    ...mapGetters({
        userRole: 'user/getUserRole'
    })
  },

  components: {
      
  },
  methods: {
  }

}
</script>


<!--Style-->
<style>

</style>