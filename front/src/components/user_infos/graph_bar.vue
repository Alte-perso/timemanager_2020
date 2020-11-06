<template>
  <div>
    <h1 class="mx-8 mt-5" :class="$style.mainTitle">Working time of last {{ timeLapse }} :</h1>
    <BarChart
      v-if="!loading && errorMessage == ''"
      class="mx-3"
      id="bar"
      :data="durations"
      bar-colors='["#36A2EB"]'
      xkey="day"
      ykeys='["duration"]'
      grid="true"
      grid-text-weight="bold"
      resize="true"
      >
    </BarChart>
      <v-row class="d-flex justify-center" :class="$style.loading">
        <v-progress-circular
        v-if="loading"
        :size="70"
        :width="7"
        color="primary"
        indeterminate
      ></v-progress-circular>
      </v-row>
      <p class="mb-0" :class="$style.errorMessage">{{errorMessage}}</p>
  </div>
</template>

<script>
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { BarChart } from "vue-morris";
import {mapGetters } from "vuex";
import { EventBus } from "@/main";

  export default {
    components: {
      BarChart
    },
    data() {
      return {
        timeLapse: "week",
        loading: true,
        errorMessage: "",
        workingtimes: [],
        durations: [],
      }
    },
    computed: {
    ...mapGetters(["userState"]),
    getStart() {
      let current_d = new Date(Date.now());
      if(this.timeLapse == "week") {
        let d_week = new Date(Date.parse(current_d) - 7 * 24 * 60 * 60 * 1000);
        let year_week = d_week.getFullYear();
        let month_week = d_week.getMonth() + 1;
        let day_week = d_week.getDate() + 1;
        return year_week + "-" + this.zeroPadding(month_week, 2) + "-" + this.zeroPadding(day_week, 2) + " 00:00:00"
       } 
       else {
        let d_month = new Date(Date.parse(current_d) - 30 * 24 * 60 * 60 * 1000);
        let year_month = d_month.getFullYear();
        let month_month = d_month.getMonth() + 1;
        let day_month = d_month.getDate() + 1;
        return year_month + "-" + this.zeroPadding(month_month, 2) + "-" + this.zeroPadding(day_month, 2) + " 00:00:00"
      }
    }
    },
    methods: {
      getDuration(start, end) {
        let duration = (end - start)/1000;
        let tempHeure = (duration - (duration % 3600));
        let heure = tempHeure / 3600;
        duration = duration - tempHeure;
        let tempMinutes = (duration - (duration % 60));
        let minutes = tempMinutes / 60;
        let secondes = duration - tempMinutes;
        duration = this.zeroPadding(heure, 2) + ":" + this.zeroPadding(minutes, 2 )+ ":" + this.zeroPadding(secondes, 2)
        return duration;
      },
      zeroPadding(num, digit) {
        var zero = "";
        for (var i = 0; i < digit; i++) {
          zero += "0";
        }
        return (zero + num).slice(-digit);
      },
      getWorkingTimes() {
        this.loading = true;
        this.durations = []
        this.axios.get(process.env.VUE_APP_URL_API + "workingtimes/" + this.userState.id + "?start=" + this.getStart) 
        .then( data => {
          this.workingtimes = data.data.data;
          this.workingtimes.forEach(workingtime => {
            let working = new Object();
            working.day = workingtime.start.split("T")[0];
            working.duration = this.getDuration(new Date(workingtime.start), new Date(workingtime.end));
            this.durations.push(working);
          })
          this.loading = false;
        })
        .catch(errors => {
            this.loading = false;
            this.errorMessage = "Oops !!  an error occured ...";
            setTimeout(() => (this.errorMessage = ""), 2000);
            console.log("ERROR : ", errors.response);
        })
      }
    },
    mounted() {
      this.getWorkingTimes();
    },
    created() {
      EventBus.$on("update-filter", (filter) => {
        this.timeLapse = filter;
      });
    },
    watch: {
      timeLapse: function () {
        this.getWorkingTimes()
      }
    },
  }
</script>

<style lang="scss" module>
.mainTitle{
  color: white;
}

.loading {
  margin-top: 70px;
}

.errorMessage {
  margin-top: 20px;
  color: red;
  text-align: center;
  font-size: 2em;
}
</style>