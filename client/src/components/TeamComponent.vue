<!-- Template -->

<template>
    <div>
        <h1>Team</h1>

        <b-button v-if="userIsManagerOrAdmin">Créer une team</b-button>
    </div>
</template>


<!-- Script -->
<script>
export default {
  name: 'app',
  data() {
      return {
          'userIsManagerOrAdmin': false
      }
  },
  components: {
      
  },
  methods: {
      getIsUserManagerOrArdmin(isManagerOrAdmin){
          this.userIsManagerOrAdmin = isManagerOrAdmin;
      }
  }

}
</script>


<!--Style-->
<style>

</style>