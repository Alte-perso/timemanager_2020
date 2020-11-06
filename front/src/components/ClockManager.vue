<template>
  <v-row
    class="d-flex justify-space-around align-center"
    :class="$style.mainContainer"
  >
    <div>
      <h1 :class="$style.titleWorkStart">Start working :</h1>
      <v-row class="d-flex justify-space-around">
        <v-btn tile color="green accent-3" @click="start" v-if="running == false">
          <v-icon left>
            mdi-play
          </v-icon>
          Start
        </v-btn>
        <!-- <v-btn tile color="red accent-3" @click="stop">
          <v-icon left>
            mdi-pause
          </v-icon>
          Pause
        </v-btn> -->
        <v-btn tile color="orange lighten-3" @click="reset(); sendClock();" v-else>
          <v-icon left>
            mdi-stop
          </v-icon>
          Stop
        </v-btn>
      </v-row>
      <span :class="[$style.chrono]">{{ timeChrono }}</span>
    </div>
  </v-row>
</template>

<script>
import { mapGetters } from "vuex";
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
      running: false,
      lastClock : {
        id: null,
        status: null,
        time: null
      },
      Clock: {
        status: true,
        time: ""
      }
    };
  },
  methods: {
    //init createdClock
    initClock() {
      this.Clock.status = true;
      let todayNow = new Date(Date.now());
      let year = todayNow.getFullYear();
      let month = todayNow.getMonth() + 1;
      let day = todayNow.getDay() + 1;
      let hours = todayNow.getHours();
      let minutes = todayNow.getMinutes(); 
      this.Clock.time =
        year + "-" + 
        this.zeroPrefix(month, 2) + "-" + 
        this.zeroPrefix(day, 2) + " " + 
        this.zeroPrefix(hours, 2) + ":" + 
        this.zeroPrefix(minutes, 2) + ":00";
    },
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

      this.sendClock();
      this.started = setInterval(this.clockRunning, 10);
      this.running = true;
    },
    stop() {
      this.running = false;
      this.timeStopped = new Date();
      clearInterval(this.started);
    },
    sendClock() {
      this.initClock();
      this.createNewClock();
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
    getLastClock() {
      //get last clock from the connected user :
      this.axios.get(process.env.VUE_APP_URL_API + "clocks/" + this.userState.id + "/last")
      .then( data => {
        console.log(data);
        this.lastClock.id = data.data.data.id;
        this.lastClock.status = data.data.data.status;
        this.lastClock.time = data.data.data.time;
        this.running = this.lastClock.status;
      })
    },
    getLastClockMounted(){
      this.axios.get(process.env.VUE_APP_URL_API + "clocks/" + this.userState.id + "/last")
      .then( data => {
        this.lastClock.id = data.data.id;
        this.lastClock.status = data.data.data.status;
        this.lastClock.time = data.data.data.time;
        this.running = this.lastClock.status;
        if (this.lastClock.status) {
          this.timeBegan = new Date(this.lastClock.time);
          this.started = setInterval(this.clockRunning, 10);
          this.running = true
        }
      })
    },
    createNewClock() {
      this.axios.post(process.env.VUE_APP_URL_API + "clocks/" + this.userState.id, {
        clock: {
          status: true,
          time: this.Clock.time
        }
      }).then(data => {
        console.log(data);
        this.getLastClock();
      })
    }
  },
  computed: {
    ...mapGetters(["userState"])
  },
  mounted() {
    this.timeBegan = null;
    this.timeStopped = null;
    this.stoppedDuration = 0;
    this.started = null;
    this.running = false;
    this.getLastClockMounted();
  }
};
</script>

<style lang="scss" module>
.clock {
  color: black;
  height: 200px;
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
  text-align: center;
  color: black;
}

.chrono {
  font-family: "Share Tech Mono", monospace;
  color: black;
  height: 200px;
  font-size: 40px;
}
</style>
