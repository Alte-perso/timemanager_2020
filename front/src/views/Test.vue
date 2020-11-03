<template>
  <div class="home">
    <h1>Short term indicator</h1>
    <GraphBar><GraphBar>
    <GraphLine></GraphLine> 
    <h1>Mid term indicator</h1>
    <Alert></Alert>
    <h1>Long term indicator</h1>
    <GraphDonut></GraphDonut>
  </div>
</template>

<script>
// @ is an alias to /src
import GraphBar from "@/components/Graphs/GraphBar";
import GraphDonut from "@/components/Graphs/GraphDonut";
import GraphLine from "@/components/Graphs/GraphLine";
import Alert from "@/components/Graphs/Alert";
export default {
  components: {
    GraphBar,
    GraphDonut,
    GraphLine, 
    Alert
  }
};
</script>

<style lang="scss" module>
h1 {
  color:white;
  font-style:italic;
}
</style>