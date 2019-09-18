<template>
    <div id="charts">
        <div class="chart-group">
            <!-- Chart 1 -->
            <div class="chart-view">
                <div class="box-header with-border">
                    <h3 class="box-title">Hours / day worked</h3>
                </div>
                <div class="box-body chart-responsive">
                    <div v-if="chartWorkingTimesData.length != 0">
                        <line-chart
                        id="line" :data="chartWorkingTimesData" xkey="day" ykeys='[ "hours"]' resize="false"
                        labels='[ "Hours worked"]' line-colors='[ "#FF6384"]'
                        grid="true" grid-text-weight="bold">
                        </line-chart>
                    </div>
                    <div v-else>No Data</div>
                </div>
            </div>
            <!-- Chart 2 -->
            <!-- <div class="chart-view">
                <div class="box-header with-border">
                    <h3 class="box-title">Donut Chart</h3>
                </div>
                <div class="box-body chart-responsive">
                    <div class="chart" id="sales-chart" style="height: 300px; position: relative;"><svg height="300" version="1.1" width="555" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="overflow: hidden; position: relative; top: -0.200012px;"><desc>Created with Raphaël 2.3.0</desc><defs></defs><path style="opacity: 0;" fill="none" stroke="#3c8dbc" d="M277.5,243.33333333333331A93.33333333333333,93.33333333333333,0,0,0,365.7277551949771,180.44625304313007" stroke-width="2" opacity="0"></path><path style="" fill="#3c8dbc" stroke="#ffffff" d="M277.5,246.33333333333331A96.33333333333333,96.33333333333333,0,0,0,368.56364732624417,181.4248826052307L405.1151459070204,194.03833029452744A135,135,0,0,1,277.5,285Z" stroke-width="3"></path><path style="opacity: 0;" fill="none" stroke="#f56954" d="M365.7277551949771,180.44625304313007A93.33333333333333,93.33333333333333,0,0,0,193.7848462783141,108.73398312817662" stroke-width="2" opacity="0"></path><path style="" fill="#f56954" stroke="#ffffff" d="M368.56364732624417,181.4248826052307A96.33333333333333,96.33333333333333,0,0,0,191.09400205154563,107.40757544301087L156.4120097954186,90.31165416754118A135,135,0,0,1,405.1151459070204,194.03833029452744Z" stroke-width="3"></path><path style="opacity: 1;" fill="none" stroke="#00a65a" d="M193.7848462783141,108.73398312817662A93.33333333333333,93.33333333333333,0,0,0,277.47067846904883,243.333328727518" stroke-width="2" opacity="1"></path><path style="" fill="#00a65a" stroke="#ffffff" d="M191.09400205154563,107.40757544301087A96.33333333333333,96.33333333333333,0,0,0,277.46973599126824,246.3333285794739L277.45601770357325,289.999993091277A140,140,0,0,1,151.92726941747117,88.10097469226493Z" stroke-width="3"></path><text style="text-anchor: middle; font-family: &quot;Arial&quot;; font-size: 15px; font-weight: 800;" x="277.5" y="140" text-anchor="middle" font-family="&quot;Arial&quot;" font-size="15px" stroke="none" fill="#000000" font-weight="800" transform="matrix(1.4068,0,0,1.4068,-112.8978,-60.5173)" stroke-width="0.7108134769258045"><tspan dy="5.25">Mail-Order Sales</tspan></text><text style="text-anchor: middle; font-family: &quot;Arial&quot;; font-size: 14px;" x="277.5" y="160" text-anchor="middle" font-family="&quot;Arial&quot;" font-size="14px" stroke="none" fill="#000000" transform="matrix(1.9444,0,0,1.9444,-262.0833,-143.5556)" stroke-width="0.5142857142857143"><tspan dy="5">20</tspan></text></svg></div>
                </div>
            </div> -->
        </div>
        <div class="chart-group">
            <!-- Chart 3 -->
            <!-- <div class="chart-view">

                <div class="box-header with-border">
                    <h3 class="box-title">Bar Chart</h3>
                </div>
                <div class="box-body chart-responsive">
                    <div class="chart" id="bar-chart" style="height: 300px;"><svg height="300" version="1.1" width="555" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="overflow: hidden; position: relative; top: -0.200012px;"><desc>Created with Raphaël 2.3.0</desc><defs></defs><text style="text-anchor: end; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="33.5" y="262.5" text-anchor="end" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal"><tspan dy="4">0</tspan></text><path style="" fill="none" stroke="#aaaaaa" d="M46,262.5H530" stroke-width="0.5"></path><text style="text-anchor: end; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="33.5" y="203.125" text-anchor="end" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal"><tspan dy="4">25</tspan></text><path style="" fill="none" stroke="#aaaaaa" d="M46,203.125H530" stroke-width="0.5"></path><text style="text-anchor: end; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="33.5" y="143.75" text-anchor="end" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal"><tspan dy="4">50</tspan></text><path style="" fill="none" stroke="#aaaaaa" d="M46,143.75H530" stroke-width="0.5"></path><text style="text-anchor: end; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="33.5" y="84.375" text-anchor="end" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal"><tspan dy="4">75</tspan></text><path style="" fill="none" stroke="#aaaaaa" d="M46,84.375H530" stroke-width="0.5"></path><text style="text-anchor: end; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="33.5" y="25" text-anchor="end" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal"><tspan dy="4">100</tspan></text><path style="" fill="none" stroke="#aaaaaa" d="M46,25H530" stroke-width="0.5"></path><text style="text-anchor: middle; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="495.42857142857144" y="275" text-anchor="middle" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal" transform="matrix(1,0,0,1,0,6.25)"><tspan dy="4">2012</tspan></text><text style="text-anchor: middle; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="357.14285714285717" y="275" text-anchor="middle" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal" transform="matrix(1,0,0,1,0,6.25)"><tspan dy="4">2010</tspan></text><text style="text-anchor: middle; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="218.85714285714286" y="275" text-anchor="middle" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal" transform="matrix(1,0,0,1,0,6.25)"><tspan dy="4">2008</tspan></text><text style="text-anchor: middle; font-family: sans-serif; font-size: 12px; font-weight: normal;" x="80.57142857142857" y="275" text-anchor="middle" font-family="sans-serif" font-size="12px" stroke="none" fill="#888888" font-weight="normal" transform="matrix(1,0,0,1,0,6.25)"><tspan dy="4">2006</tspan></text><rect x="54.64285714285714" y="25" width="24.428571428571427" height="237.5" rx="0" ry="0" fill="#00a65a" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="82.07142857142857" y="48.75" width="24.428571428571427" height="213.75" rx="0" ry="0" fill="#f56954" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="123.78571428571428" y="84.375" width="24.428571428571427" height="178.125" rx="0" ry="0" fill="#00a65a" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="151.2142857142857" y="108.125" width="24.428571428571427" height="154.375" rx="0" ry="0" fill="#f56954" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="192.92857142857142" y="143.75" width="24.428571428571427" height="118.75" rx="0" ry="0" fill="#00a65a" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="220.35714285714283" y="167.5" width="24.428571428571427" height="95" rx="0" ry="0" fill="#f56954" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="262.07142857142856" y="84.375" width="24.428571428571427" height="178.125" rx="0" ry="0" fill="#00a65a" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="289.5" y="108.125" width="24.428571428571427" height="154.375" rx="0" ry="0" fill="#f56954" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="331.2142857142857" y="143.75" width="24.428571428571427" height="118.75" rx="0" ry="0" fill="#00a65a" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="358.64285714285717" y="167.5" width="24.428571428571427" height="95" rx="0" ry="0" fill="#f56954" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="400.35714285714283" y="84.375" width="24.428571428571427" height="178.125" rx="0" ry="0" fill="#00a65a" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="427.7857142857143" y="108.125" width="24.428571428571427" height="154.375" rx="0" ry="0" fill="#f56954" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="469.5" y="25" width="24.428571428571427" height="237.5" rx="0" ry="0" fill="#00a65a" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect><rect x="496.92857142857144" y="48.75" width="24.428571428571427" height="213.75" rx="0" ry="0" fill="#f56954" stroke="none" style="fill-opacity: 1;" fill-opacity="1"></rect></svg><div class="morris-hover morris-default-style" style="left: 46.5714px; top: 112px; display: none;"><div class="morris-hover-row-label">2006</div><div class="morris-hover-point" style="color: #00a65a">
        CPU:
        100
        </div><div class="morris-hover-point" style="color: #f56954">
        DISK:
        90
        </div></div></div>
                </div>
            
            </div> -->
        </div>
    </div>
</template>


<script>
// This component defines many Charts.

import { mapState, mapActions } from 'vuex'

import Raphael from 'raphael/raphael'
global.Raphael = Raphael
import { LineChart } from 'vue-morris'
// import { DonutChart, BarChart, LineChart, AreaChart } from 'vue-morris'


const moment = require('moment');
moment().format();

export default {
    name: 'ChartManager',

    data() {
        return {
            chartWorkingTimesData: []
        }
    },

    mounted () {

        let myInterval = setInterval(() => {
            if (this.chartWorkingTimesData.length == 0) {
                this.getChartWorkingTimes()
                clearInterval(myInterval)
            }
        }, 1000);


    },

    components: {
       LineChart
    },

    methods: {
        getChartWorkingTimes () {
            const workingTimesData = this.$store.state.workingtime.workingTimes

            let chartWKTDatas = []
            let daysTab = []

            for (const item of workingTimesData) {
                // split start and end and get the date and time
                let startDatetime = moment(item.start)
                let endDatetime = moment(item.end)
                let tempDate = startDatetime

                if (endDatetime.diff(startDatetime, 'days') >= 1) { // the user continuously worked between 2 differents dates
                    // iterate through the days and get the numbers of hours worked for each day
                    for (let index = 0; index < endDatetime.diff(startDatetime, 'days'); index++) {
                        // get number of hours worked for this day
                        let numberOfMillisecondsWorked = moment().endOf('day').diff(tempDate)
                        // check if this date is already present in our tab
                        let pos = chartWKTDatas.map(function(e) { return e.day; }).indexOf(tempDate.format('YYYY-MM-DD'))
                        if (pos == -1) { // this day of work isn't in the tab - insert it
                            chartWKTDatas.push({
                                day: tempDate.format('YYYY-MM-DD'),
                                milliseconds: numberOfMillisecondsWorked
                            })
                        } else {
                            chartWKTDatas[pos].milliseconds += numberOfMillisecondsWorked
                        }

                        // add 1 day to tempDate
                        tempDate = startDatetime.add(1, 'd')
                    }
                } else { // the user worked on the same day
                    // get numbers of hours worked
                    let numberOfMillisecondsWorked = endDatetime.diff(startDatetime)
                    // check if this date is already present in our tab
                    let pos = chartWKTDatas.map(e => { return e.day; }).indexOf(tempDate.format('YYYY-MM-DD'))
                    if (pos == -1) { // this day of work isn't in the tab - insert it
                        chartWKTDatas.push({
                            day: tempDate.format('YYYY-MM-DD'),
                            milliseconds: numberOfMillisecondsWorked
                        })
                    } else {
                        chartWKTDatas[pos].milliseconds += numberOfMillisecondsWorked
                    }
                }
            }

            // iterate through our parsed data cvhart to transform milliseconds to hours.
            for (let i = 0; i < chartWKTDatas.length; i++) {
                let MS = chartWKTDatas[i].milliseconds
                chartWKTDatas[i].hours = Math.round(MS / 3600000)
            }

            this.chartWorkingTimesData = chartWKTDatas
        }
    }

    
}

</script>