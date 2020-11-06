<template>
  <div>
    <!-- Average paid hours per total hours -->
    <template v-if="moy_hsup_htot < 0.3 ">
      <v-alert
        type="success"
      >Average deviation rate between overtime and statutory hours: {{ moy_hsup_htot }}</v-alert>
    </template>
    <template v-else-if="moy_hsup_htot > 0.4" >
      <v-alert
        type="error"
      >Average deviation rate between overtime and statutory hours: {{ moy_hsup_htot }}</v-alert>
    </template>
    <template v-else>
      <v-alert
        type="warning"
      >Average deviation rate between overtime and statutory hours: {{ moy_hsup_htot }}</v-alert>   
    </template>
  </div>
</template>

<script>
export default {
  data() {
    return {
      moy_hsup_htot: 0.5
    };
  }
};
</script>