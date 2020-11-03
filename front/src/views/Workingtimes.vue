<template>
  <div>
    <v-col>
      <Workingtime></Workingtime>
    </v-col>
        <v-col>
      <Workingtimes></Workingtimes>
    </v-col>
  </div>
</template>

<script>
import Workingtime from "@/components/WorkingTime";
import Workingtimes from "@/components/WorkingTimes";
export default {
  components: {
    Workingtime,
    Workingtimes
  }
};
</script>

<style lang="scss" module></style>
