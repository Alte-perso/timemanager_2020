<template>
  <div>
    <v-btn class="mx-5" @click="backToWorkingtimes">
      <v-icon left>mdi-arrow-left</v-icon>
      Back
    </v-btn>
    <h1 :class="$style.mainTitle" class="mx-5">Edit your workingtime : </h1>
    <v-col>
      <Workingtime :edit="true" :working_id="this.$route.params.id"></Workingtime>
    </v-col>
  </div>
</template>

<script>
import Workingtime from "@/components/WorkingTime";

export default {
  components: {
    Workingtime,
  },
  methods: {
    backToWorkingtimes() {
      this.$router.push({name:"Workingtimes"});
    }
  }
};
</script>

<style lang="scss" module>
.mainTitle {
  color: white;
}
</style>
