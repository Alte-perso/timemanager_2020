<template>
  <v-card class="overflow-hidden">
    <v-app-bar
      :class="$style.appBar"
      absolute
      dark
      app
      :src="imgGotham"
      fixed
      flat
      height="64px"
    >
      <!-- <template v-slot:img="{ props }">
        <v-img
          v-bind="props"
          gradient="to top right, rgba(19,84,122,.5), rgba(128,208,199,.8)"
        ></v-img>
      </template> -->

       <v-app-bar-nav-icon @click.stop="drawer = !drawer" v-if="this.$vuetify.breakpoint.smAndDown"></v-app-bar-nav-icon>

      <v-toolbar-title class="mr-5">Gotham City</v-toolbar-title>

      <div v-if="this.$vuetify.breakpoint.mdAndUp" class="d-flex">
        <v-btn value="Home" class="d-flex align-center" text @click="goTo('Home')">
          <v-icon left>mdi-home</v-icon>
          <span>Home</span>
        </v-btn>

        <v-btn value="Workingtimes" class="d-flex align-center" text @click="goTo('Workingtimes')" >
          <v-icon left>mdi-clock</v-icon>
          <span>My working times</span>
        </v-btn>

        <v-btn value="Team" class="d-flex align-center" text @click="goTo('Team')">
          <v-icon left>mdi-account-multiple</v-icon>
          <span>My team</span>
        </v-btn>
      </div>

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
          <v-list-item @click="goTo('Home')">
            <v-list-item-icon>
              <v-icon>mdi-home</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>Home</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item @click="goTo('Workingtimes')">
           <v-list-item-icon>
              <v-icon> mdi-clock</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title>My working times</v-list-item-title>
            </v-list-item-content>
          </v-list-item>

          <v-list-item @click="goTo('Team')">
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
      
      <div
        style="min-height: 100vh; margin-top: 64px; padding-top: 25px"
        :class="$style.mainContainer"
      >
        <router-view></router-view>
      </div>
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
  methods: {
    goTo(pathName) {
      this.$router.push({name: pathName})
    }
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
