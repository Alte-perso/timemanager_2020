<template>
  <div class="home">
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
  </div>
</template>

<script>
// @ is an alias to /src
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { BarChart } from "vue-morris";

export default {
  components: {
    BarChart,
  },
  data() {
    return {
      barData: [
        { day: 'monday', RegularHours: 8, SupPayedHours: 1, SupUnpayedHours:0 },
        { day: 'tuesday', RegularHours: 7, SupPayedHours: 0, SupUnpayedHours:0 },
        { day: 'wendsday', RegularHours: 8, SupPayedHours: 1, SupUnpayedHours:1 },
        { day: 'thirsday', RegularHours: 8, SupPayedHours: 1, SupUnpayedHours:0 },
      ],
    };
  }
};
</script>
