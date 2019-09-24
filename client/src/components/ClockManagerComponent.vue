<template>
    <div id="clock" class="div-content">
        <div class="sub sub-header">
            <h2>Clock Manager</h2>
        </div>
        <div class="sub sub-content">
            <b-card bg-variant="light">

                <div v-if="!clockInProgress">
                    <b-card-text>
                        You are actually not clocked in.
                    </b-card-text>
                    <transition appear name="fade" mode="out-in">
                        <b-button variant="outline-success" v-on:click="clock">Do you want to clock IN ?</b-button>
                    </transition>
                </div>
                <div v-else>
                    <b-card-text>
                        You are clocked in since :
                    </b-card-text>
                    <b-card-text>
                        <b>{{ clockedInSince }}</b>
                    </b-card-text>
                    <transition appear name="fade" mode="out-in">
                        <b-button variant="outline-danger" v-on:click="clock">Do you want to clock OUT ?</b-button>
                    </transition>
                </div>
            </b-card>
        </div>
    </div>
</template>


<script>
// This component defines the Clock manager.
import { mapState, mapActions } from 'vuex'

export default {
    name: 'ClockManager',

    computed: {
        ...mapState('clock', {
            startDateTime: state => state.startDateTime,
            clockInProgress: state => state.clockInProgress,
        }),
        ...mapState('user', {
            userId: state => state.user.id,
        }),

        clockedInSince() {
            return this.startDateTime
        }
    },

    methods: {
        clock() {
            this.$store.dispatch('clock/clock', this.userId)
        }
    }
}

</script>