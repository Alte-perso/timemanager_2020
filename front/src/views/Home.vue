<template>
  <div>
    <v-row class="mx-3">
      <v-col>
      <InfoUser></InfoUser>
      </v-col>
      <v-col>
        <GeneralInfosUser></GeneralInfosUser>
      </v-col>
    </v-row>
    <GraphHours></GraphHours>
  </div>
</template>

<script>
import InfoUser from "@/components/user_infos/UserInfo";
import GeneralInfosUser from "@/components/user_infos/GeneralInfo";
import GraphHours from "@/components/user_infos/graph_bar.vue";
export default {
  components: {
    InfoUser,
    GeneralInfosUser,
    GraphHours
  }
};
</script>

<style lang="scss" module></style>
