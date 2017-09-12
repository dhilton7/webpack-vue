<template>
  <div>
    <v-card-title>
      <h4>Log In</h4>
    </v-card-title>
    <v-card-text>
      <form action="/users/sign_in" method="post" id="sign-in-form">
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
      </form>
    </v-card-text>
    <v-card-actions>
      <v-btn medium success @click="signIn">Sign In!</v-btn>
      <button type="submit" form="sign-in-form">Do it</button>
    </v-card-actions>
  </div>
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
        password: ''
      }
    },
    methods: {
      signIn() {
        axios.post('/users/sign_in.json', {
          user: {
            email: this.email,
            password: this.password
          }
        })
          .then(function(response) {
            console.log(response)
          })
          .catch(function(error) {
            console.log(error)
          })
      }
    }
  }
</script>