<template>
  <v-row
    class="d-flex justify-space-around align-center"
    :class="$style.mainContainer"
  >
    <!-- CURRENT TIME -->
    <div
      :class="[$style.cardCurrentHour, $style.clock]"
      class="d-flex flex-column justify-center align-center"
    >
      <p class="mb-0" :class="$style.text">Current time :</p>
      <p class="mb-0" :class="$style.date">{{ date }}</p>
      <p class="mb-0" :class="$style.time">{{ time }}</p>
    </div>
    <div>
      <h1 :class="$style.titleWorkStart">Start working :</h1>
      <v-row class="d-flex justify-space-around">
        <v-btn tile color="green accent-3" @click="start">
          <v-icon left>
            mdi-play
          </v-icon>
          Start
        </v-btn>
        <v-btn tile color="red accent-3" @click="stop">
          <v-icon left>
            mdi-pause
          </v-icon>
          Stop
        </v-btn>
        <v-btn tile color="orange lighten-3" @click="reset">
          <v-icon left>
            mdi-stop
          </v-icon>
          Reset
        </v-btn>
      </v-row>
      <span :class="[$style.chrono]">{{ timeChrono }}</span>
    </div>
  </v-row>
</template>

<script>
var week = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
export default {
  data() {
    return {
      time: "",
      date: "",
      timeChrono: "00:00:00.000",
      timeBegan: null,
      timeStopped: null,
      stoppedDuration: 0,
      started: null,
      running: false
    };
  },
  methods: {
    //Chrono Functions
    start() {
      if (this.running) return;
      if (this.timeBegan === null) {
        this.reset();
        this.timeBegan = new Date();
      }

      if (this.timeStopped !== null) {
        this.stoppedDuration += new Date() - this.timeStopped;
      }

      this.started = setInterval(this.clockRunning, 10);
      this.running = true;
    },
    stop() {
      this.running = false;
      this.timeStopped = new Date();
      clearInterval(this.started);
    },
    reset() {
      this.running = false;
      clearInterval(this.started);
      this.stoppedDuration = 0;
      this.timeBegan = null;
      this.timeStopped = null;
      this.timeChrono = "00:00:00.000";
    },
    clockRunning() {
      var currentTime = new Date(),
        timeElapsed = new Date(
          currentTime - this.timeBegan - this.stoppedDuration
        ),
        hour = timeElapsed.getUTCHours(),
        min = timeElapsed.getUTCMinutes(),
        sec = timeElapsed.getUTCSeconds(),
        ms = timeElapsed.getUTCMilliseconds();

      this.timeChrono =
        this.zeroPrefix(hour, 2) +
        ":" +
        this.zeroPrefix(min, 2) +
        ":" +
        this.zeroPrefix(sec, 2) +
        "." +
        this.zeroPrefix(ms, 3);
    },
    zeroPrefix(num, digit) {
      var zero = "";
      for (var i = 0; i < digit; i++) {
        zero += "0";
      }
      return (zero + num).slice(-digit);
    },
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
    this.timeBegan = null;
    this.timeStopped = null;
    this.stoppedDuration = 0;
    this.started = null;
    this.running = false;
    setInterval(this.updateTime, 1000);
  }
};
</script>

<style lang="scss" module>
.clock {
  font-family: "Share Tech Mono", monospace;
  color: #ffffff;
  color: #daf6ff;
  height: 200px;
  text-shadow: 0 0 20px rgba(10, 175, 230, 1), 0 0 20px rgba(10, 175, 230, 0);
  .time {
    letter-spacing: 0.05em;
    font-size: 40px;
  }
  .date {
    letter-spacing: 0.1em;
    font-size: 24px;
  }
  .text {
    letter-spacing: 0.1em;
    font-size: 12px;
  }
}

.titleWorkStart {
  color: #ffffff;
  color: #daf6ff;
  text-shadow: 0 0 20px rgba(10, 175, 230, 1), 0 0 20px rgba(10, 175, 230, 0);
}

.chrono {
  font-family: "Share Tech Mono", monospace;
  color: #ffffff;
  color: #daf6ff;
  height: 200px;
  text-shadow: 0 0 20px rgba(10, 175, 230, 1), 0 0 20px rgba(10, 175, 230, 0);    letter-spacing: 0.05em;
  font-size: 40px;

}
</style>
