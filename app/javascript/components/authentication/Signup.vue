<template>
  <div>
    <v-card-title>
      <h4>Log In</h4>
    </v-card-title>
    <v-card-text>
      <v-text-field
        label="Email"
        v-model="email"
        required
        class="mt-3"
      ></v-text-field>

      <v-text-field
        label="Password"
        v-model="password"
        required
        class="mt-3"
      ></v-text-field>

      <v-text-field
        label="Password Confirmation"
        v-model="password_confirmation"
        required
        class="mt-3"
      ></v-text-field>
    </v-card-text>
    <v-card-actions>
      <v-btn medium success @click="signUp">Sign Me Up!</v-btn>
    </v-card-actions>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    data() {
      return {
        email: '',
        password: '',
        password_confirmation: ''
      }
    },
    methods: {
      signUp() {
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