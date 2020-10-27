<template>
  <v-card class="mx-5 mt-5 px-5">
    <!-- ###### SELECT DATE ###### -->
    <v-row>
      <!-- ###### START DATE ###### -->
      <v-col class="d-flex flex-column justify-center align-center">
        <h1>Start Date</h1>
        <v-menu
          v-model="menuStartDate"
          :close-on-content-click="false"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="290px"
          dark
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="startDate"
              label="Start date"
              prepend-icon="mdi-calendar"
              readonly
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="startDate"
            @input="menuStartDate = false"
          ></v-date-picker>
        </v-menu>
        <!-- ##### START HOUR ##### -->
        <v-menu
          ref="menuStartHour"
          v-model="menuStartHour"
          :close-on-content-click="false"
          :nudge-right="40"
          :return-value.sync="startHour"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="290px"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="startHour"
              label="Start time"
              prepend-icon="mdi-clock-time-four-outline"
              readonly
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
          </template>
          <v-time-picker
            v-if="menuStartHour"
            v-model="startHour"
            full-width
            format="24hr"
            @click:minute="$refs.menuStartHour.save(startHour)"
          ></v-time-picker>
        </v-menu>
      </v-col>
      <!-- ###### END DATE ###### -->
      <v-col class="d-flex flex-column justify-center align-center">
        <h1>End Date</h1>
        <v-menu
          v-model="menuEndDate"
          :close-on-content-click="false"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="290px"
          dark
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="endDate"
              label="End date"
              prepend-icon="mdi-calendar"
              readonly
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="endDate"
            @input="menuEndDate = false"
          ></v-date-picker>
        </v-menu>
        <!-- ##### END HOUR ##### -->
        <v-menu
          ref="menuEndHour"
          v-model="menuEndHour"
          :close-on-content-click="false"
          :nudge-right="40"
          :return-value.sync="endHour"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="290px"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="endHour"
              label="End time"
              prepend-icon="mdi-clock-time-four-outline"
              readonly
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
          </template>
          <v-time-picker
            v-if="menuEndHour"
            v-model="endHour"
            full-width
            format="24hr"
            @click:minute="$refs.menuEndHour.save(endHour)"
          ></v-time-picker>
        </v-menu>
      </v-col>
    </v-row>
    <v-card-actions class="justify-space-between">
      <span :class="$style.errorMsg">{{ errorMessage }}</span>
      <span :class="$style.successMsg">{{ successMessage }}</span>
      <v-btn color="primary" @click="createWorkingTime()" :loading="loading"
        >Save</v-btn
      >
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters } from "vuex";
import { bus } from "@/main";

export default {
  data() {
    return {
      loading: false,
      errorMessage: "",
      successMessage: "",
      date: new Date().toISOString().substr(0, 10),
      startDate: new Date().toISOString().substr(0, 10),
      endDate: new Date().toISOString().substr(0, 10),
      menuStartDate: false,
      menuStartHour: false,
      menuEndDate: false,
      menuEndHour: false,
      startHour: "09:30",
      endHour: "17:30"
    };
  },
  computed: {
    ...mapGetters(["userState"])
  },
  methods: {
    initMessages() {
      this.errorMessage = "";
      this.successMessage = "";
    },
    createWorkingTime() {
      this.initMessages();
      this.loading = true;
      this.axios
        .post(process.env.VUE_APP_URL_API + "workingtimes", {
          workingtime: {
            start: this.startDate + " " + this.startHour + ":00",
            end: this.endDate + " " + this.endHour + ":00",
            user: this.userState.id
          }
        })
        .then(result => {
          this.loading = false;
          bus.$emit("getWorkingTimes");
          this.successMessage = "Your working time has been registered";
          setTimeout(
            function() {
              this.initMessages();
            }.bind(this),
            4000
          );
          console.log(result);
        })
        .catch(error => {
          this.loading = false;
          this.errorMessage = "Oops, an error occured... ";
          setTimeout(
            function() {
              this.initMessages();
            }.bind(this),
            4000
          );

          console.log(error);
        });
    }
  }
};
</script>

<style lang="scss" module>
.errorMsg {
  color: #e53935;
}

.successMsg {
  color: #00c853;
}
</style>
