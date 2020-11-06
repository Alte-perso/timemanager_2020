<template>
  <div> 
    <v-btn @click="backToTeams">
      <v-icon left>mdi-arrow-left</v-icon>
      Back
    </v-btn>
    <h1 :class="$style.mainTitle">Team Name : {{teamName}}</h1>  
    <v-data-table
      :headers="headers"
      :items="teams"
      :items-per-page="5"
      class="elevation-1"
    >

      <template v-slot:item.email="{ item }">
        <a :href="`mailto:${item.email}`">{{item.email}}</a>
      </template>

    </v-data-table>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        teamName : "Super team",
        headers: [
          {
            text: 'Member firstname',
            align: 'start',
            value: 'firstname',
          },
          { text: 'Member Lastname', value: 'lastname' },
          { text: 'Member email', value: 'email' },
          { text: 'Member role', value: 'role' },
        ],
        teams: [
          {id: 1, firstname: "Firstname", lastname: "lastname", email: "example@gmail.com", role:"admin" }
        ]
      };
    },
    methods: {
      backToTeams() {
        this.$router.push({name: 'Teams'});
      }
    }
  }
</script>

<style lang="scss" module>
.mainTitle {
  color: white;
}
</style>