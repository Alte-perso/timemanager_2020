<template>
  <BarChart
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
</template>

<script>
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { BarChart } from "vue-morris";

  export default {
    components: {
      BarChart
    },
    data() {
      return {
        barData: [
          {"day": "2020-11-01", "duration": 2},
          {"day": "2020-11-02", "duration": 3},
          {"day": "2020-11-03", "duration": 4},
          {"day": "2020-11-04", "duration": 5},
          {"day": "2020-11-05", "duration": 6}
        ]
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>