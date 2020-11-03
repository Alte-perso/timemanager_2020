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

       <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

      <v-toolbar-title>Dashboard Gotham City</v-toolbar-title>

      <v-spacer></v-spacer>

      <User></User>

      <!-- <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn> -->
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      absolute
      left
      temporary
    >
      <v-list
        nav
        dense
      >
        <v-list-item-group
          v-model="group"
          active-class="blue--text text--accent-4"
        >
          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-home</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>Home</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item>
           <v-list-item-icon>
              <v-icon> mdi-clock</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>My working times</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-account-multiple</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>My team</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>



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
      drawer: false,
      group: null,
      imgGotham: require("@/assets/gotham.jpg")
    };
  },
  watch: {
    group () {
      this.drawer = false
    },
  },
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
