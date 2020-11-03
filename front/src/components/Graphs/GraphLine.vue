<template>
  <div>
    <!-- Supl hour evolution -->
    <LineChart
      id="line"
      :data="lineData"
      line-colors='[ "#FF6384", "#36A2EB" ]'
      xkey="day"
      ykeys='["SupHours"]' 
      grid="true"
      grid-text-weight="bold"
      resize="true">      
    </LineChart>
  </div>
</template>

<script>
// @ is an alias to /src
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { LineChart } from "vue-morris";
export default {
    components: {
      LineChart
    },
  data() {
    return {
      lineData: [
        { day: "monday", SupHours: 0 },
        { day: "tuesday", SupHours: 1 },
        { day: "wendsday", SupHours: 4 },
        { day: "thirsday", SupHours: 2 }, 
      ]
    };
  }
};
</script>