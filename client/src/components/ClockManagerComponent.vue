<template>
        <div id="clock" class="div-content">
            <div class="sub sub-header">
                <h2>Clock Manager</h2>
            </div>
            <div class="sub sub-content">
                <div v-if="!clockInProgress">
                    <transition appear name="fade" mode="out-in">
                        <b-button variant="success" v-on:click="clock">Do you want to clock IN ?</b-button>
                    </transition>
                </div>
                <div v-else>
                    <transition appear name="fade" mode="out-in">
                        <b-button variant="danger" v-on:click="clock">Do you want to clock OUT ?</b-button>
                    </transition>
                </div>
            </div>
        </div>
</template>


<script>
// This component defines the Clock manager.
import { mapState, mapActions } from 'vuex'

export default {
    name: 'ClockManager',

    computed:
        mapState({
            startDateTime: state => state.clock.startDateTime,
            clockInProgress: state => state.clock.clockInProgress
        }),

    mounted() {
        this.$store.dispatch('clock')
    },

    methods: {
        clock() {
            this.$store.dispatch('clock')
        }
    }
}

</script>