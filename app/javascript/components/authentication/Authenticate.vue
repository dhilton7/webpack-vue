<template>
  <v-app>
    <main>
      <v-container fluid>
        <v-layout row wrap>
          <v-flex xs6>
          </v-flex>
          <v-flex xs6>
            <v-card>
              <router-view></router-view>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </main>
  </v-app>
</template>


<script>
  import Login from './Login.vue'
  import Signup from './Signup.vue'

  export default {
    components: {
      login: Login,
      signup: Signup
    },
    data() {
      return {
        email: '',
        password: '',
        password_confirmation: '',
        login: true,
        valid: true
      }
    }
  }
</script>
