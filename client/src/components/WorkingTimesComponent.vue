<template>
    <div id="workingtime" class="div-content">
        <div class="sub sub-header">
            <h2>Working Times</h2>
            <b-button>ADD</b-button>
        </div>
        <div class="sub sub-content">
            <b-table hover :items="items"></b-table>
        </div>
    </div>
</template>



<script>
// This component defines many WorkingTimes.

export default {
    name: 'WorkingTimes',

    props: [
    ],

    data() {
        return {
            items: [
                { id: 40, start: '2019-12-09 12:00:10', end: '2019-12-09 12:00:10' },
                { id: 21, start: '2019-11-25 10:50:00', end: '2019-11-25 10:50:00' },
                { id: 89, start: '2019-10-01 08:25:10', end: '2019-10-01 08:25:10' },
                { id: 38, start: '2019-08-07 19:00:10', end: '2019-08-07 19:00:10' }
            ]
        }
    },

    components: {

    },

    mounted() {

    },

    methods: {

    }
}

</script>