<template>
  <div>
    <ClockManager></ClockManager>
    <WorkingTimes></WorkingTimes>
    <WorkingTime></WorkingTime>
  </div>
</template>

<script>
import ClockManager from "@/components/ClockManager";
import WorkingTimes from "@/components/WorkingTimes";
import WorkingTime from "@/components/WorkingTime";
export default {
  components: {
    ClockManager,
    WorkingTimes,
    WorkingTime
  }
};
</script>

<style lang="scss" module></style>
