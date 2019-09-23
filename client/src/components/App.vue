<template>
  <div id="app">
    <!-- Navbar -->
    <div id="navbar">
      <b-navbar toggleable="md" type="dark" variant="dark" sticky>
        <b-navbar-brand class="text-yellow" href="#">Gotham - A Time Manager</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>


        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="navbar-links mr-auto ml-auto">
            <router-link to="/" class="nav-link text-yellow">Home</router-link>
            <router-link to="/team" class="nav-link text-yellow">Teams</router-link>
            <router-link to="/users" class="nav-link text-yellow">Users</router-link>

            <div id="user-links-collapsed">
              <li class="nav-item">
                <a class="nav-link text-primary" href="#" v-b-modal.modal-edit>Edit account</a>
              </li>
              <li class="nav-item">
                <a class="nav-link text-danger" href="#" v-b-modal.modal-delete>Delete account</a>
              </li>
            </div>
          </b-navbar-nav>

        </b-collapse>
        <!-- Right aligned nav items -->
        <b-navbar-nav id="user-links">
            <UserComponent @userLoggedIn="setUserLoggedIn"></UserComponent>
        </b-navbar-nav>
      </b-navbar>
    </div>

    <!-- Content -->
    <div id="main-content" class="container-fluid">
      <router-view></router-view>
    </div>
    
  </div>
</template>

<script>
import { mapGetters, mapState } from 'vuex'
import UserComponent from './UserComponent.vue'
import db from "../storage"

export default {
  name: 'app',
  data() {
    return {
      'userLoggedIn': false
    }
  },
  mounted() {
    // listen the connectivity of the user
    document.addEventListener("online", this.onDeviceOnline, false);
    document.addEventListener("offline", this.onDeviceOffline, false);
  },
  components: {
    UserComponent
  },
  computed: {
    ...mapState('clock', {
        startDateTime: state => state.startDateTime,
        clockInProgress: state => state.clockInProgress,
    }),
    ...mapState('user', {
        user: state => state.user,
        users: state => state.listUsers
    }),
    ...mapState('workingtime', {
        workingtimes: state => state.workingTimes
    }),
  },
  methods: {
      setUserLoggedIn(loggedIn) {
          this.userLoggedIn = loggedIn;
      },
      onDeviceOnline() {
        console.log('device online')
        // check if there is actions to perform on postgres database storage initialized
        if (localStorage.length != 0 && db.exist('actions')) {
          // get the actions datas
          let actions = db.getJson('actions')
          console.log(actions)

          // Exemple d'actions à réaliser
          // actions = [
          //   {
          //     name: 'user/updateUser',
          //     data: { id: 'toto', email: 'test@email.com', username: 'test' }
          //   },
          //   {
          //     name: 'clock/clock',
          //     data: userId
          //   },
          //   ...
          // ]

          actions.forEach(element => this.$store.dispatch(element['name'], element['data']))

          // clear actions local storage
          db.remove('actions')
        }
      },
      onDeviceOffline() {
        console.log('device offline')
        // save the states in local storage
        db.store('user', this.user)
        db.store('users', this.users)
        db.store('startDateTime', this.startDateTime)
        db.store('clockInProgress', this.clockInProgress)
        db.store('workingtimes', this.workingtimes)
        db.store('actions', [])
      },
      setActionOffline(e) {
        console.log('action offline to set')
        console.log(e.name, e.data)
        db.storeAction(e.name, e.data)
      }
  }
}
</script>

<style>
@import url('../assets/fontawesome/css/all.css');
@import url('../assets/css/style.css');
@import url('../assets/css/transition.css');
</style>
