<template>
  <div>
    <v-data-table
      :headers="headers"
      :items="teams"
      :items-per-page="5"
      class="elevation-1"
    >
      <template v-slot:item.actions="{ item }">
        <v-btn @click="showTeamDetail(item.id)">view</v-btn>
      </template>
    
    </v-data-table>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        headers: [
          {
            text: 'Team name',
            align: 'start',
            value: 'team_name',
          },
          { text: 'Number of members', value: 'nbr_membres' },
          { text: 'Voir', value: 'actions' },
        ],
        teams: [
          {team_name: "Tech team", nbr_membres: 3, actions: "View" }
        ]
      };
    }
  }
</script>

<style lang="scss" module>

</style>