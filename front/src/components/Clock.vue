<template>
    <!-- CURRENT TIME -->
    <div
      :class="[$style.cardCurrentHour, $style.clock]"
      class="d-flex flex-column justify-center align-center"
    >
      <p class="mb-0" :class="$style.text">Current time :</p>
      <p class="mb-0" :class="$style.date">{{ date }}</p>
      <p class="mb-0" :class="$style.time">{{ time }}</p>
    </div>
</template>

<script>
var week = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  export default {
    methods: {
        //Current time Functions
      updateTime() {
        var cd = new Date();
        this.time =
          this.zeroPadding(cd.getHours(), 2) +
          ":" +
          this.zeroPadding(cd.getMinutes(), 2) +
          ":" +
          this.zeroPadding(cd.getSeconds(), 2);
        this.date =
          this.zeroPadding(cd.getFullYear(), 4) +
          "-" +
          this.zeroPadding(cd.getMonth() + 1, 2) +
          "-" +
          this.zeroPadding(cd.getDate(), 2) +
          " " +
          week[cd.getDay()];
      },
      zeroPadding(num, digit) {
        var zero = "";
        for (var i = 0; i < digit; i++) {
          zero += "0";
        }
        return (zero + num).slice(-digit);
      }
    },
    mounted() {
      setInterval(this.updateTime, 1000);
    }
  }
</script>

<style lang="scss" module>

</style>