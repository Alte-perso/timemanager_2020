<template>
  <div class="home">   
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
  </div> 
</template>

<script>
export default {
  components: {
    Alert,
  },
  data() {
    return {
      moy_hsup_htot: 0.5
    };
  }
};
</script>