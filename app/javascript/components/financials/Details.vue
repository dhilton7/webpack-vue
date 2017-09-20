<template>
  <v-layout row wrap>
    <v-flex xs12>
      <h3>Details for sheet id: {{ $route.params.id }}</h3>
    </v-flex>
    <v-flex xs12>
      <v-card>
        <v-card-text>
          <v-text-field type="number" label="Amount" v-model="amount"></v-text-field>
          <v-select
            :items="categories"
            v-model="category"
            label="Select Category"
            autocomplete
          ></v-select>
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
        amount: 0,
        category: '',
        categories: [],
        properties: []
      }
    },
    created() {
      const self = this
      axios.get(`/sheets/${this.$route.params.id}`).then((response) => {
        console.log(response.data)
      });

      axios.get('/entry_categories').then((response) => {
        self.categories = response.data.payload
      })

      axios.get('/properties').then((response) => {
        self.properties = response.data.payload
      })
    }
  }
</script>
