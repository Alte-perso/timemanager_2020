<template>
  <div class="mx-5 d-flex flex-column justify-center">
    <h1 :class="$style.mainTitle" class="mx-5">Your teams : </h1>
    <Team></Team>
  </div>
</template>

<script>
import Team from "@/components/user_infos/Team";

export default {
  components: {
    Team
  }
};
</script>

<style lang="scss" module>
.mainTitle {
  color: white;
}
</style>
