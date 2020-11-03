<template>
  <div :class="$style.userInfo">
    <v-row>
      <v-col class="d-flex flex-column justify-center align-center"> 
        <v-avatar size="120">
          <v-img :src="imgDefaultAvatar"></v-img>
        </v-avatar>
        <p>Username: </p>
      </v-col>
      <v-col>
        <div>
          <p>Firstname : </p>
          <p>Lastname : </p>
          <p>Role : </p>
          <p>Equipes : </p>
        </div>
      </v-col>
    </v-row>
    <v-divider />
    <ClockManager></ClockManager>
  </div>
</template>

<script>
import ClockManager from "@/components/ClockManager" 
  export default {
    components: {
      ClockManager
    },
    data() {
      return {
        imgDefaultAvatar: require("@/assets/default-avatar.png")
      }
    }
  }
</script>

<style lang="scss" module>
.userInfo {
  background-color: white;
  border-radius: 4px;
}
</style>