<template>
  <div :class="$style.generalInfo">
    <h1 :class="$style.mainTitle">General informations</h1>
      <v-row class="d-flex justify-space-around align-center mx-5 mt-5">
        <p class="mb-0" :class="$style.subTitle">Working time during : </p>
      </v-row>
      <v-row class="d-flex justify-center align-center mx-5">
        <v-btn @click="filter = 'week'" :class="filter == 'week' ? $style.activeBtn : ''" class="mx-1">Last week</v-btn>
        <v-btn @click="filter = 'month'" :class="filter == 'month' ? $style.activeBtn : ''" class="mx-1">Last month</v-btn>
      </v-row>
      <h1 :class="$style.workingHours">25 h</h1>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        filter: "week",
        imgDefaultAvatar: require("@/assets/default-avatar.png")
      }
    }
  }
</script>

<style lang="scss" module>
.generalInfo {
  background-color: white;
  border-radius: 4px;
  height: 330px;
}

.mainTitle {
  text-align: center;
}

.subTitle {
  text-align: center;
}

.workingHours {
  margin-top: 20px;
  text-align: center;
  font-size: 6em;
}

.activeBtn {
  background-color: #2196F3 !important;
  color: white !important;
}
</style>