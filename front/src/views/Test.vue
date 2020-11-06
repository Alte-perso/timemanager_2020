<template>
  <div>
    <!-- Choose the team or the member to see-->
    <v-toolbar
      dense
      floating
      >
        <v-text-field
          hide-details
          prepend-icon="mdi-magnify"
          single-line
        ></v-text-field>
    </v-toolbar>
    <h1>Short term indicator</h1>
    <h2>Repartition of the number of working hour per day</h2>
    <GraphBar></GraphBar>
    <h2>Number of supplement hours</h2>
    <GraphLine></GraphLine>
    <h1>Mid term indicator</h1>
    <h2>Degree of compliance to labor code</h2>
    <Alert></Alert>
    <h1>Long term indicator</h1>
    <h2>Repartition of the mandatory time per project</h2>
    <GraphDonut></GraphDonut>
  </div>
</template>

<script>
// @ is an alias to /src
import GraphBar from "@/components/Graphs/GraphBar";
import GraphLine from "@/components/Graphs/GraphLine";
import Alert from "@/components/Graphs/Alert";
import GraphDonut from "@/components/Graphs/GraphDonut";
export default {
  name: "Home",
  components: {
    GraphDonut,
    GraphBar,
    GraphLine,
    Alert
  },
};
</script>

<style lang="scss" module>
h1 {
  color:white;
  font-style:italic;
}
h2 {
  color:white;
  font-style:italic;
}
</style>