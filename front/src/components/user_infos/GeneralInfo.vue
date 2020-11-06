<template>
  <div :class="$style.generalInfo">
    <h1 :class="$style.mainTitle">General informations</h1>
      <v-row class="d-flex justify-space-around align-center mx-5 mt-5">
        <p class="mb-0" :class="$style.subTitle">Working time during : </p>
      </v-row>
      <v-row class="d-flex justify-center align-center mx-5">
        <v-btn @click="setFilter('week')" :class="filter == 'week' ? $style.activeBtn : ''" class="mx-1">Last week</v-btn>
        <v-btn @click="setFilter('month')" :class="filter == 'month' ? $style.activeBtn : ''" class="mx-1">Last month</v-btn>
      </v-row>
      <h1 v-if="!loading && errorMessage == ''" :class="$style.workingHours">{{allWorkingDuration}}</h1>
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
import {mapGetters } from "vuex";
import {EventBus} from "@/main.js"
  export default {
    data() {
      return {
        loading: false,
        errorMessage: "",
        filter: "week",
        imgDefaultAvatar: require("@/assets/default-avatar.png"),
        workingtimes: [],
        durations: [],
        allWorkingDuration: 0,
      }
    },
    computed: {
    ...mapGetters(["userState"]),
    getStart() {
      let current_d = new Date(Date.now());
      if(this.filter == "week") {
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
      setFilter(filter){
        this.filter = filter;
        EventBus.$emit("update-filter", filter);
      },
      getDuration(start, end) {
        let duration = (end - start)/1000;
        let tempHeure = (duration - (duration % 3600));
        let heure = tempHeure / 3600;
        duration = duration - tempHeure;
        let tempMinutes = (duration - (duration % 60));
        let minutes = tempMinutes / 60;
        let secondes = duration - tempMinutes;
        duration = this.zeroPadding(heure, 2) + ":" + this.zeroPadding(minutes, 2) + ":" + this.zeroPadding(secondes, 2)
        return duration;
      },
      zeroPadding(num, digit) {
        var zero = "";
        for (var i = 0; i < digit; i++) {
          zero += "0";
        }
        return (zero + num).slice(-digit);
      },
      getTotalDurations() {
        let heures_temp=0, minutes_temp=0, secondes_temp=0, heures=0, minutes=0, secondes =0;
        this.durations.forEach(element => {
          console.log(element.duration);
          heures_temp += parseInt(element.duration.split(":")[0]);
          console.log("heure", heures_temp);
          minutes_temp += parseInt(element.duration.split(":")[1]);
          secondes_temp += parseInt(element.duration.split(":")[2]);
        })
        secondes = secondes_temp % 60;
        minutes = (minutes_temp + (secondes_temp - secondes) / 60) % 60
        heures = heures_temp + ((minutes_temp + (secondes_temp - secondes) / 60) - minutes) /60
        this.allWorkingDuration = heures + "H et " + minutes + " min" 
      },
      getWorkingTimes() {
        this.loading = true;
        this.durations = [];
        this.axios.get(process.env.VUE_APP_URL_API + "workingtimes/" + this.userState.id + "?start=" + this.getStart) 
        .then( data => {
          console.log(data.data.data);
          this.workingtimes = data.data.data;
          this.workingtimes.forEach(workingtime => {
            let working = new Object();
            working.duration = this.getDuration(new Date(workingtime.start), new Date(workingtime.end));
            this.durations.push(working);
          })
          this.loading = false;
          this.getTotalDurations()
        })
        .catch(errors => {
            this.loading = false;
            this.errorMessage = "Oops !!  an error occured ...";
            setTimeout(() => (this.errorMessage = ""), 2000);
            console.log("ERROR : ", errors.response);
        })
      }
    },
    created() {
      EventBus.$on("getWorkingTimes", () => {
        this.getWorkingTimes();
      });
    },
    mounted() {
      this.getWorkingTimes();
    },
    watch: {
      filter: function () {
        this.getWorkingTimes()
      }
    },
  }
</script>

<style lang="scss" module>
.generalInfo {
  background-color: white;
  border-radius: 4px;
  height: 330px;
}

.mainTitle {
  text-align: center;
}

.subTitle {
  text-align: center;
}

.workingHours {
  margin-top: 60px;
  text-align: center;
  font-size: 2.9em;
}

.activeBtn {
  background-color: #2196F3 !important;
  color: white !important;
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