<template>
  <div class="home">
    <h1>Short term indicator</h1>
    <!-- Repartition of the number of hours spend to work per day -->
    <BarChart
      id="bar"
      :data="barData"
      bar-colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
      xkey='day'
      ykeys='[ "RegularHours", "SupPayedHours", "SupUnpayedHours" ]' 
      grid="true"
      grid-text-weight="bold"
      resize="true">
    </BarChart>
    <!-- Supl hour evolution -->
    <LineChart
      id="line"
      :data="lineData"
      line-colors='[ "#FF6384", "#36A2EB" ]'
      xkey='day'
      ykeys='["SupHours"]' 
      grid="true"
      grid-text-weight="bold"
      resize="true">      
    </LineChart>
    <h1>Mid term indicator</h1>
    <!-- Average paid hours per total hours -->
    <template v-if="moy_hsup_htot < 0.3 ">
      <v-alert
        type="success"
      >Taux d'écart moyen heures sup/heures réglementaire: {{ moy_hsup_htot }}</v-alert>
    </template>
    <template v-else-if="moy_hsup_htot > 0.4" >
      <v-alert
        type="error"
      >Taux d'écart moyen heures sup/heures réglementaire: {{ moy_hsup_htot }}</v-alert>
    </template>
    <template v-else>
      <v-alert
        type="warning"
      >Taux d'écart moyen heures sup/heures réglementaire: {{ moy_hsup_htot }}</v-alert>   
    </template>
    <h1>Long term indicator</h1>
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
      moy_hsup_htot: 0.5,
      donutData: [
        { label: "Regular hours", value: 8 },
        { label: "Sup payed hours", value: 1 },
        { label: "Sup unpayed hours", value: 0 }
      ],  
      barData: [
        { day: 'monday', RegularHours: 8, SupPayedHours: 1, SupUnpayedHours:0 },
        { day: 'tuesday', RegularHours: 7, SupPayedHours: 0, SupUnpayedHours:0 },
        { day: 'wendsday', RegularHours: 8, SupPayedHours: 1, SupUnpayedHours:1 },
        { day: 'thirsday', RegularHours: 8, SupPayedHours: 1, SupUnpayedHours:0 },
      ],
      lineData: [
        { day: 'monday', SupHours: 0 },
        { day: 'tuesday', SupHours: 1 },
        { day: 'wendsday', SupHours: 4 },
        { day: 'thirsday', SupHours: 2 }, 
      ]
    };
  }
};
</script>

<style lang="scss" module>
h1 {
  color:white;
  font-style:italic;
}
</style>