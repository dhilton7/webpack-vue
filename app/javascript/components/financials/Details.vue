<template>
  <v-layout row wrap pa-4>
    <v-flex xs12>
      <h3>{{ sheetTitle }}</h3>
    </v-flex>
    <v-flex xs12>
      <v-card>
        <v-card-text>
          <v-layout row>
            <v-flex xs12 md4 ma-3>
              <v-select
                :items="properties"
                v-model="property"
                label="Select Property"
                autocomplete>
              </v-select>
              <v-select 
                :items="categories"
                v-model="category"
                label="Select Category"
                autocomplete
              ></v-select>
              <v-text-field label="Account" v-model="account"></v-text-field>
            </v-flex>
            <v-flex xs6 md3 ma-3>
              <v-text-field type="number" label="Amount" v-model="amount"></v-text-field>
              <v-menu
                lazy
                v-model="dateMenu"
                transition="scale-transition"
                offset-y
                full-width
                :nudge-left="40"
                max-width="290px"
              >
                <v-text-field
                  slot="activator"
                  label="Date"
                  v-model="entryDate"
                  prepend-icon="event"
                  readonly
                ></v-text-field>
                <v-date-picker v-model="entryDate" no-title scrollable actions>
                </v-date-picker>
              </v-menu>
              <v-checkbox label="Paid?" v-model="paid"></v-checkbox>
            </v-flex>
            <v-flex xs12 md6 mr-3 ml-3>
              <v-text-field
                v-model="notes"
                label="Notes"
                multi-line
              ></v-text-field>
              <v-btn primary @click="saveEntry">Save Entry</v-btn>
            </v-flex>
          </v-layout>
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
        account: '',
        category: '',
        property: '',
        entryDate: '',
        notes: '',
        paid: false,
        dateMenu: false,
        categories: [],
        properties: [],
        sheetInfo: {},
      }
    },
    methods: {
      saveEntry() {
        // TODO: control whether this is a create or update
        this.createEntry()
      },
      createEntry() {
        const self = this
        axios.post(`/sheets/${this.$route.params.id}/entries`, {
          amount: this.amount,
          account: this.account,
          description: this.notes,
          paid: this.paid,
          date: this.entryDate,
          property_id: this.property,
          entry_category_id: this.category,
        })
      }
    },
    computed: {
      sheetTitle() {
        return `${this.sheetInfo.title} ${this.sheetInfo.year}`
      }
    },
    created() {
      const self = this
      axios.get(`/sheets/${this.$route.params.id}.json`).then((response) => {
        self.sheetInfo = response.data.payload
        // TODO: get response and display pertinent information
      });

      axios.get('/entry_categories.json').then((response) => {
        self.categories = response.data.payload
      })

      axios.get('/properties?address_only=true.json').then((response) => {
        self.properties = response.data.properties 
      })
    }
  }
</script>