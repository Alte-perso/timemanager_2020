<template>
  <div class="mx-5">
    <v-slide-y-transition class="py-0" origin="top center 0">
      <v-row
        :class="$style.actionAndFilterRow"
        v-if="!(selectedItem.length == 0)"
        class="d-flex justify-end align-center mx-0"
      >
        <v-btn color="warning" class="mr-5" icon>
          <v-icon>mdi-delete</v-icon>
        </v-btn>
      </v-row>
    </v-slide-y-transition>
    <v-data-table
      :headers="headers"
      :items="workingTimes"
      :items-per-page="5"
      class="elevation-1"
    >
      <template v-slot:item.delete="{ item }">
        <div @click="updateSelected(item.id)">
          <div v-if="isSelected(item.id)" :class="$style.customCheckBox"></div>
          <v-avatar
            color="green darken-1"
            v-else
            :class="$style.customCheckBoxChecked"
            size="35"
          >
            <v-icon color="white">mdi-check</v-icon>
          </v-avatar>
        </div>
      </template>
      <template v-slot:item.duration="{ item }">
        <v-chip :color="getColor(item.duration)" dark>
          {{ item.duration }}
        </v-chip>
      </template>
    </v-data-table>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import { bus } from "@/main";

export default {
  data() {
    return {
      selectedItem: [],
      headers: [
        { text: "", value: "delete", sortable: false },
        { text: "User id", value: "userId" },
        {
          text: "Start date",
          value: "start"
        },
        { text: "End date", value: "end" },
        { text: "Duration", value: "duration" },
        { text: "Extra hours", value: "extraHours" }
      ],
      workingTimes: []
    };
  },
  methods: {
    updateSelected(id) {
      if (this.selectedItem.indexOf(id) == -1) {
        this.selectedItem.push(id);
      } else {
        this.selectedItem.splice(this.selectedItem.indexOf(id), 1);
      }
    },
    isSelected(id) {
      if (this.selectedItem.indexOf(id) == -1) {
        return true;
      } else {
        return false;
      }
    },
    getDuration(milliseconds) {
      //Get hours from milliseconds
      var hours = milliseconds / (1000 * 60 * 60);
      var absoluteHours = Math.floor(hours);
      var h = absoluteHours > 9 ? absoluteHours : "0" + absoluteHours;

      //Get remainder from hours and convert to minutes
      var minutes = (hours - absoluteHours) * 60;
      var absoluteMinutes = Math.floor(minutes);
      var m = absoluteMinutes > 9 ? absoluteMinutes : "0" + absoluteMinutes;

      //Get remainder from minutes and convert to seconds
      var seconds = (minutes - absoluteMinutes) * 60;
      var absoluteSeconds = Math.floor(seconds);
      var s = absoluteSeconds > 9 ? absoluteSeconds : "0" + absoluteSeconds;

      return h + ":" + m + ":" + s;
    },
    getColor(duration) {
      let splitDuration = duration.split(":");
      if (splitDuration[0] > 7) {
        return "red accent-3";
      } else if (splitDuration[0] > 6) {
        return "orange accent-3";
      } else {
        return "green accent-3";
      }
    },
    getExtraHours(duration) {
      let hours = duration.split(":")[0];
      let minuts = duration.split(":")[1];
      let seconds = duration.split(":")[2];
      if (hours >= 8) {
        return hours - 8 + ":" + minuts + ":" + seconds;
      } else {
        return "0";
      }
    },
    getWorkingTimes() {
      this.workingTimes = [];
      if (this.userState.id != null) {
        this.axios
          .get(
            process.env.VUE_APP_URL_API + "workingtimes/" + this.userState.id
          )
          .then(response => {
            let result = response.data.data;
            result.forEach(workingTimeElement => {
              Object.defineProperty(workingTimeElement, "userId", {
                value: this.userState.id
              });
              let start = Date.parse(workingTimeElement.start);
              let end = Date.parse(workingTimeElement.end);
              let durationMilliSec = end - start;
              let duration = this.getDuration(durationMilliSec);
              Object.defineProperty(workingTimeElement, "duration", {
                value: duration
              });
              Object.defineProperty(workingTimeElement, "extraHours", {
                value: this.getExtraHours(duration)
              });
              this.workingTimes.push(workingTimeElement);
            });
          })
          .catch(error => {
            console.log("ERROR", error);
          });
      }
    }
  },
  computed: {
    ...mapGetters(["userState"])
  },
  created() {
    bus.$on("getWorkingTimes", () => {
      this.getWorkingTimes();
    });
  },
  mounted() {
    this.getWorkingTimes();
  }
};
</script>

<style lang="scss" module>
.actionAndFilterRow {
  background-color: #757575;
  border-radius: 4px;
  height: 45px;
}

.customCheckBox {
  width: 35px;
  height: 35px;
  border: 1px solid #757575;
  border-radius: 50%;
  cursor: pointer;
}

.customCheckBoxChecked {
  width: 35px;
  height: 35px;
  border: 1px solid #43a047;
  border-radius: 50%;
  cursor: pointer;
}

.slide-fade-enter-active {
  transition: all .3s ease;
}
.slide-fade-leave-active {
  transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  transform: translateX(10px);
  opacity: 0;
}
</style>
