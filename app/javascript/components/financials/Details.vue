<template>
  <v-layout row wrap pa-4>
    <v-flex xs9>
      <h3>{{ sheetTitle }}</h3>
    </v-flex>
    <v-flex xs1 offset-xs2>
      <v-btn icon @click="isEditing = true"><v-icon>add_box</v-icon></v-btn>
      <router-link to="/financials">
        <v-icon>arrow_back</v-icon>
      </router-link>
    </v-flex>
    <v-flex xs4 lg3 v-for="(header, index) in sheetInfo.headers" :key="header.id">
      <v-card>
        <v-card-text>
          <div class="text-xs-center">
            <div class="headline">{{ header.name }}</div>
            <div class="display-1">{{ header.value }}</div>
          </div>
        </v-card-text>
      </v-card>
    </v-flex>
    <v-flex xs12 v-if="isEditing">
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
              <v-btn color="grey lighten-2" @click="isEditing = false">Cancel</v-btn>
            </v-flex>
          </v-layout>
        </v-card-text>
      </v-card>
    </v-flex>
    <v-flex xs12 v-for="(entry, index) in sheetInfo.entries" :key="entry.id">
      <v-layout row>
        <v-flex xs8>
          <v-card>
            <v-card-title>
              <div>
                <h5 class="headline mb-0">{{ entry.category_name }}</h5>
                <p>{{ entry.address }}</p>
              </div>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs2 offset-xs2 v-if="entry.debit">
          <v-card>
            <v-card-title>
              <span class="headline">{{ entry.amount }}</span>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs2 v-else>
          <v-card>
            <v-card-title>
              <span class="headline">{{ entry.amount }}</span>
            </v-card-title>
          </v-card>
        </v-flex>
      </v-layout>
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
        amount: 0,
        account: '',
        category: '',
        property: '',
        entryDate: '',
        notes: '',
        paid: false,
        dateMenu: false,
        isEditing: false,
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
        return `${this.sheetInfo.title || ''} ${this.sheetInfo.year || ''}`
      }
    },
    created() {
      const self = this
      axios.get(`/sheets/${this.$route.params.id}.json`).then((response) => {
        self.sheetInfo = response.data.payload
        self.categories = response.data.categories
        self.properties = response.data.properties
      });
    }
  }
</script>
