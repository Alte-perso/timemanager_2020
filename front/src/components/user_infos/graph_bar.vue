<template>
  <div>
    <h1 class="mx-8 mt-5" :class="$style.mainTitle">Working time of last {{ timeLapse }} :</h1>
    <BarChart
      class="mx-3"
      id="bar"
      :data="barData"
      bar-colors='["#36A2EB"]'
      xkey="day"
      ykeys='["duration"]'
      grid="true"
      grid-text-weight="bold"
      resize="true"
      >
    </BarChart>
  </div>
</template>

<script>
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { BarChart } from "vue-morris";

  export default {
    components: {
      BarChart
    },
    props: {
      timeLapse: {
        type: String,
        default: "week"
      }
    },
    data() {
      return {
        barData: [
          {"day": "2020-11-01", "duration": 2},
          {"day": "2020-11-02", "duration": 3},
          {"day": "2020-11-03", "duration": 4},
          {"day": "2020-11-04", "duration": 5},
          {"day": "2020-11-06", "duration": 6},
          {"day": "2020-11-07", "duration": 6},
          {"day": "2020-11-08", "duration": 6},
          {"day": "2020-11-09", "duration": 6},
          {"day": "2020-11-10", "duration": 6},
          {"day": "2020-11-11", "duration": 6},
          {"day": "2020-11-12", "duration": 6},
          {"day": "2020-11-13", "duration": 6},
          {"day": "2020-11-14", "duration": 6},
          {"day": "2020-11-15", "duration": 6},
          {"day": "2020-11-16", "duration": 6},
          {"day": "2020-11-17", "duration": 6},
          {"day": "2020-11-18", "duration": 6},

        ]
      }
    }
  }
</script>

<style lang="scss" module>
.mainTitle{
  color: white;
}
</style>