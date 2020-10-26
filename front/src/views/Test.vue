<template>
  <div class="home">
    <DonutChart
      id="donut"
      :data="donutData"
      colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
      resize="true"
      >></DonutChart
    >
    <BarChart></BarChart>
  </div>
</template>

<script>
// @ is an alias to /src
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { DonutChart, BarChart } from "vue-morris";

export default {
  name: "Home",
  components: {
    DonutChart,
    BarChart
  },
  data() {
    return {
      donutData: [
        { label: "Red", value: 300 },
        { label: "Blue", value: 50 },
        { label: "Yellow", value: 100 }
      ]
    };
  }
};
</script>
