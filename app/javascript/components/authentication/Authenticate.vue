<template>
  <v-card>
    <v-card-title>
      <h4>Sign Up</h4>
    </v-card-title>
    <v-form v-model="valid">
      <v-text-field
        label="Email"
        v-model="email"
        required
      ></v-text-field>

      <v-text-field
        label="Password"
        v-model="password"
        required
      ></v-text-field>

      <v-text-field
        label="Password Confirmation"
        v-model="password_confirmation"
        required
      ></v-text-field>
    </v-form>
    <v-card-actions>
      <v-btn
        medium
        @click="signIn"
      >Sign In</v-btn>
    </v-card-actions>
  </v-card>
</template>


<script>
  import axios from 'axios'

  let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'

  export default {
    data() {
      return {
        email: '',
        password: '',
        password_confirmation: '',
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
      }
    }
  }
</script>
