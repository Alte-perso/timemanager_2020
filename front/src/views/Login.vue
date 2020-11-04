<template>
  <div class="d-flex flex-column justify-center align-center" :class="$style.mainTitle">
    <h1>Welcom in the Gotham City's time manager. </h1>
    <h2> Please login or sign in to enter !</h2>
    <v-btn color="primary mt-3" @click="openLoginPopup()">Login</v-btn>
  </div>
</template>

<script>
import {EventBus} from "@/main.js"

export default {
  methods: {
    openLoginPopup() {
      EventBus.$emit("openlogin");
    }
  }
};
</script>

<style lang="scss" module>
.mainTitle {
  text-align: center;
  height: calc( 100vh - 84px);
  color: white;
}
</style>