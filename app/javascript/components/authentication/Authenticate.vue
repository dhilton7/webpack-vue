<template>
  <v-app>
    <main>
      <v-container fluid>
        <v-layout row wrap>
          <v-flex xs6>
          </v-flex>
          <v-flex xs6>
            <v-card>
              <login v-if="login"></login>
              <signup v-else></signup>
              <v-card-actions>
                <v-btn normal @click="toggleForm">{{ toggleText }}</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </main>
  </v-app>
</template>


<script>
  import axios from 'axios'
  import Login from './Login.vue'
  import Signup from './Signup.vue'

  let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'


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
        toggleText: "Don't have an account?",
        valid: true
      }
    },
    methods: {
      signIn() {
        axios.post('/users', {
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation
        })
          .then(response => {
          console.log(response)
        })
          .catch(error => {
          console.log(error)
        })
      },
      toggleForm() {
        this.login = !this.login;
        this.toggleText = this.login == true ? "Don't have an account?" : "Sign in Now"
      }
    }
  }
</script>
