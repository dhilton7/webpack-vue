<template>
  <v-layout row wrap>
    <v-flex xs12>
      <h3>Properties</h3>
    </v-flex>
    <v-flex
      offset-xs3
      xs6
      row
      mb-3
      v-if="addForm"
    >
      <v-card>
        <v-card-title>Add New Property</v-card-title>
        <v-card-text>
          <v-text-field
            label="Address"
            v-model="address"
          >
          </v-text-field>
          <v-text-field
            label="City"
            v-model="city"
          >
          </v-text-field>
          <v-text-field
            label="State"
            v-model="state"
          >
          </v-text-field>
          <v-text-field
            label="ZIPCode"
            v-model="zip"
          >
          </v-text-field>
        </v-card-text>
        <v-card-actions>
          <v-btn
            primary
            @click="createProperty"
          >Add Property</v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
    <v-flex xs3>
      <v-btn
        fab
        top
        right
        @click="addForm = !addForm"
      >
        <v-icon>{{ buttonState }}</v-icon>
      </v-btn>
      </v-flex>
      <p>Listing {{ count }} properties</p>
      <v-flex xs3>
        <v-card v-for="property in properties" :key="property.id">
          <v-card-title>{{ property.address }}</v-card-title>
          <v-card-text>{{ property.notes }}</v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
</template>

<script>
  import axios from 'axios'

  let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'

  export default {
    data() {
      return {
        message: 'Properties',
        addForm: false,
        address: '',
        count: 0,
        city: '',
        state: '',
        zip: '',
        properties: []
      }
    },
    computed: {
      buttonState() {
        return this.addForm == false ? 'add' : 'delete'
      }
    },
    methods: {
      getProperties() {
        var self = this
        axios.get('/properties.json')
          .then(function(response) {
            self.properties = response.data.payload.properties
            self.count = response.data.payload.count
          })
          .catch(function(error) {
            console.log(error)
        })
      },
      createProperty() {
        const self = this
        axios.post('/properties', {
          address: this.address,
          city: this.city,
          state: this.state,
          zip: this.zip
        }).then(function(response) {
          console.log(response.data.payload)
          self.properties.push(response.data.payload)
        })
      }
    },
    created() {
      this.getProperties()
    }
  }
</script>