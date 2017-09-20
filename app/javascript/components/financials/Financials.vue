<template>
  <v-layout row wrap pa-4>
    <v-flex xs6>
      <h3 style="display=inline;">Financial Statements</h3>
    </v-flex>
    <v-flex xs4 offset-xs1>
      <v-btn fab absolute right @click="displayForm = !displayForm">
          <v-icon>{{ displayCTA }}</v-icon>
        </v-btn>
      <v-card v-if="displayForm">
        <v-card-text>
          <v-text-field label="Title" v-model="title" />
          <v-text-field label="Year" v-model="year" />
        </v-card-text>
        <v-card-actions>
          <v-btn @click="createSheet">
            Create Sheet
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
    <v-flex xs12 v-for="sheet in sheets" :key="sheet.id">
      <v-card>
        <v-card-text>
          <router-link :to="`financials/${sheet.id}`">{{ sheet.title }} {{ sheet.year }}</router-link>
        </v-card-text>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
  import axios from 'axios'

  export default {
    data() {
      return {
        displayForm: false,
        title: '',
        year: '',
        sheets: [
          { id: 1, title: '2017', year: '2017' }
        ]
      }
    },
    computed: {
      displayCTA() {
        return this.displayForm == true ? 'clear' : 'add'
      }
    },
    methods: {
      createSheet() {
        const self = this
        axios.post('/sheets.json', {
          title: this.title,
          year: this.year
        }).then(function(response) {
          // todo: can't hard code id.
          self.sheets.push({ id: 100, title: self.title, year: self.year })
          self.displayForm = false
        }).catch(function(error) {
          console.log(error)
        })
      },
      getSheets() {
        const self = this
        axios.get('/sheets.json')
          .then(function(response) {
            self.sheets = response.data.payload.sheets
          }).catch(function(error) {

          })
      }
    },
    created() {
      this.getSheets()
    }
  }
</script>
