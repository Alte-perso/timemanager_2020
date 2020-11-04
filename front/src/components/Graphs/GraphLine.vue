<template>
  <div>
    <!-- Supl hour evolution -->
    <LineChart
      id="line"
      :data="lineData"
      line-colors='[ "#FF6384", "#36A2EB" ]'
      xkey="year"
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
        { year: "2013", a: 0, b:2 },
        { year: "2014", a: 1, b:4 },
        { year: "2015", a: 4, b:6 },
        { year: "2016", a: 2, b:4 }, 
      ]
    };
  }
};
</script>