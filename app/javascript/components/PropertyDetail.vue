<template>
	<v-layout row wrap>
    <v-flex xs12>
      <h2>{{ propertyData.address }}</h2>
    </v-flex>
    <v-flex xs12 v-for="(entry, index) in propertyData.entries" :key="entry.id">
      <v-layout row>
        <v-flex xs8>
          <v-card>
            <v-card-title>
              <div>
                <h5 class="headline mb-0">{{ entry.created_at }} {{ entry.category_name }}</h5>
                <p class="mb-0">{{ entry.address }}</p>
              </div>
            </v-card-title>
          </v-card>
        </v-flex>
        <v-flex xs2 offset-xs2 v-if="entry.debit">
          <div class="headline  red--text darken-2  text-xs-right  pr-2">
            {{ entry.amount }}
          </div>
        </v-flex>
        <v-flex xs2 v-else>
          <div class="headline  text-xs-right  pr-2">
            {{ entry.amount }}
          </div>
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>

<script>
  import axios from 'axios'

  export default {
    data() {
      return {
        propertyData: {}
      }
    },
    methods: {
      getPropertyInfo() {
        const self = this
        axios.get(`/properties/${this.$route.params.id}`)
        .then((response) => {
          self.propertyData = response.data.payload
        })
      }
    },
    created() {
      this.getPropertyInfo()
    }
  }

</script>