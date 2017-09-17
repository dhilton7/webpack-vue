<template>
  <v-layout row wrap>
    <v-flex xs12 pa-4>
      <h3 style="display: inline;">Properties</h3>
      <v-btn rounded small absolute right @click="showAddForm">
        <v-icon>add</v-icon>
      </v-btn>
    </v-flex>
    <v-flex
      offset-xs2
      xs8
      mb-3
      v-if="addForm"
    >
      <v-card>
        <v-card-title>
          <h5 style="display: inline">{{ formAction }}</h5>
          <v-btn fab small absolute right top style="margin-right: -35px" @click="hideAddForm">
            <v-icon>delete</v-icon>
          </v-btn>
        </v-card-title>
        <v-card-text>
          <v-text-field label="Address" v-model="address"/>
          <v-text-field label="City" v-model="city"/>
          <v-text-field label="State" v-model="state"/>
          <v-text-field label="ZIPCode" v-model="zip"/>
        </v-card-text>
        <v-card-actions>
          <div v-if="editing">
            <v-btn secondary @click="editProperty">Edit Property</v-btn>
            <v-btn @click="deleteProperty">Delete</v-btn>
          </div>
          <v-btn primary v-else @click="createProperty">Add Property</v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
    <v-flex xs4 v-for="(property, index) in properties" :key="property.id">
      <v-card>
        <v-card-text pl-3>
          <p><h6>{{ property.address }}</h6></p>
          </v-btn>
          <p>{{ property.city + ', ' + property.state + ' ' + property.zip }}</p>
        </v-card-text>
        <v-card-actions>
          <v-btn @click="showEditForm(property, index)">Edit</v-btn>
          <v-btn @click="showDetails(property)">Details</v-btn>
        </v-card-actions>
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
        editing: false,
        address: '',
        count: 0,
        city: '',
        state: '',
        zip: '',
        properties: [],
        editingPropertyId: 0,
        editingPropertyIndex: null
      }
    },
    computed: {
      buttonState() {
        return this.addForm == false ? 'add' : 'clear'
      },
      formAction() {
        return this.editing ? 'Edit Property' : 'Add New Property'
      }
    },
    methods: {
      editProperty() {
        const self = this
        axios.patch(`/properties/${this.editingPropertyId}.json`, {
          address: this.address,
          city: this.city,
          state: this.state,
          zip: this.zip
        }).then(function(response) {
          self.properties[self.editingPropertyIndex] = response.data.payload
          self.addForm = false
        })
      },
      getProperties() {
        const self = this
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
          self.properties.push(response.data.payload)
        })
      },
      deleteProperty() {
        const self = this
        axios.delete(`/properties/${this.editingPropertyId}.json`).then(function() {
          self.hideAddForm();
          self.properties.splice(self.editingPropertyIndex, 0);
        })
      },
      hideAddForm() {
        this.addForm = false
        this.editing = false
      },
      showEditForm(property, index) {
        this.addForm = true
        this.editing = true
        this.editingPropertyId = property.id
        this.editingPropertyIndex = index
        this.address = property.address
        this.city = property.city
        this.state = property.state
        this.zip = property.zip
      },
      showAddForm() {
        this.addForm = true
        this.editing = false
        this.editingPropertyId = null
        this.address = null
        this.city = null
        this.state = null
        this.zip = null
      },
    // todo: define
      showDetails() {}
    },
    created() {
      this.getProperties()
    }
  }
</script>