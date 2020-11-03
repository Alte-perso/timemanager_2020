<template>
  <div>
    <v-row>
      <v-col>
      <InfoUser></InfoUser>
      </v-col>
      <v-col>
        <GeneralInfosUser></GeneralInfosUser>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import InfoUser from "@/components/user_infos/UserInfo";
import GeneralInfosUser from "@/components/user_infos/GeneralInfo";
export default {
  components: {
    InfoUser,
    GeneralInfosUser,
  }
};
</script>

<style lang="scss" module></style>
