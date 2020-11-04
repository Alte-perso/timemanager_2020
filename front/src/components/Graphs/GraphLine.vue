<template>
  <div>
    <!-- Supl hour evolution -->
    <LineChart
      id="line"
      :data="lineData"
      line-colors='[ "#FF6384", "#36A2EB" ]'
      xkey="day"
      ykeys='["a", "b"]' 
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
        { day: "2020-11-01", a: 0, b:2 },
        { day: "2020-11-02", a: 1, b:4 },
        { day: "2020-11-03", a: 4, b:6 },
        { day: "2020-11-04", a: 2, b:4 }, 
      ]
    };
  }
};
</script>