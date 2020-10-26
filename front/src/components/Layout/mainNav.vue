<template>
  <v-card class="overflow-hidden">
    <v-app-bar
      :class="$style.appBar"
      absolute
      color="#fcb69f"
      dark
      app
      shrink-on-scroll
      :src="imgGotham"
      scroll-target="#scrolling-techniques-2"
    >
      <template v-slot:img="{ props }">
        <v-img
          v-bind="props"
          gradient="to top right, rgba(19,84,122,.5), rgba(128,208,199,.8)"
        ></v-img>
      </template>

      <v-app-bar-nav-icon></v-app-bar-nav-icon>

      <v-toolbar-title>Dashboard Gotham City</v-toolbar-title>

      <v-spacer></v-spacer>

      <User></User>

      <!-- <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn> -->
    </v-app-bar>
    <v-sheet
      id="scrolling-techniques-2"
      class="overflow-y-auto"
      max-height="100vh"
    >
      <div
        style="height: 150vh; margin-top: 130px;"
        :class="$style.mainContainer"
      >
        <router-view></router-view>
      </div>
    </v-sheet>
  </v-card>
</template>

<script>
import User from "@/components/User";
export default {
  components: {
    User
  },
  data() {
    return {
      imgGotham: require("@/assets/gotham.jpg")
    };
  }
};
</script>

<style lang="scss" module>
.appBar {
  border-radius: 0px !important;
}

.mainContainer {
  width: 100%;
  background: #0a2e38;
  background: radial-gradient(ellipse at top, #0a2e38 0%, #000000 70%);
}
</style>
