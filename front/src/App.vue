<template>
  <v-app :class="$style.mainContainer">
    <router-view></router-view>
  </v-app>
</template>

<script>
export default {
  name: "App",

  components: {},

  data: () => ({
    //
  })
};
</script>

<style lang="scss" module>
.mainContainer {
  background-color: #073631 !important;
}
</style>
