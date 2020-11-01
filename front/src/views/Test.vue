<template>
  <div class="home">
    <!-- Time per project -->
    <DonutChart
      id="donut"
      :data="donutData"
      colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
      resize="true"
      ></DonutChart>
  
  <!-- Repartition of the number of hours spend to work per day -->
  <BarChart
    id="bar"
    :data="barData"
    bar-colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
    grid="true"
    grid-text-weight="bold"
    resize="true">
  </BarChart>

  <!-- Supl hour evolution -->
  <LineChart
    id="line"
    :data="lineData"
    line-colors='[ "#FF6384", "#36A2EB" ]'
    grid="true"
    grid-text-weight="bold"
    resize="true">      
  </LineChart>

  <!-- Average paid hours per total hours -->

  </div>  
</template>

<script>
// @ is an alias to /src
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { DonutChart, BarChart, LineChart } from "vue-morris";

export default {
  name: "Home",
  components: {
    DonutChart,
    BarChart,
    LineChart
  },
  data() {
    return {
      donutData: [
        { label: "Regular hours", value: 8 },
        { label: "Sup payed hours", value: 1 },
        { label: "Sup unpayed hours", value: 0 }
      ],
      lineData: [
        { date: "01/10", "sup hours": 0 },
        { date: "02/10", "sup hours": 1 },
        { date: "03/10", "sup hours": 2 },
        { date: "04/10", "sup hours": 3 },
        { xkey: "date" },
        { ykeys:"sup hours" },   
      ],  
      chartData: [
        { date: "01/10", "Regular hours": 8, "Sup payed hours": 1, "Sup unpayed hours":0 },
        { date: "02/10", "Regular hours": 7, "Sup payed hours": 0, "Sup unpayed hours":0 },
        { date: "03/10", "Regular hours": 8, "Sup payed hours": 1, "Sup unpayed hours":1 },
        { date: "04/10", "Regular hours": 8, "Sup payed hours": 1, "Sup unpayed hours":0 },
        { xkey:"date" },
        { ykeys:'[ "Regular hours", "Sup payed hours", "Sup unpayed hours" ]' },
      ]
    };
  }
};
</script>