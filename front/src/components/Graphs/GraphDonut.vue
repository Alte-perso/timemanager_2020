<template>
  <div class="home">
    <!-- Time per project -->
    <DonutChart
      id="donut"
      :data="donutData"
      colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
      resize="true"
    ></DonutChart>
  </div>
</template>

<script>
// @ is an alias to /src
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { DonutChart } from "vue-morris";
export default {
  components: {
    DonutChart
  },
  data() {
    return {
      donutData: [
        { label: "Regular hours", value: 8 },
        { label: "Sup payed hours", value: 1 },
        { label: "Sup unpayed hours", value: 0 }
      ]
    }
  }
};
</script>
