<template>
  <div class="home">
    <h1>Short term indicator</h1>
    <GraphBar></GraphBar>
    <GraphLine></GraphLine>
    <h1>Mid term indicator</h1>
    <Alert></Alert>
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
</style>