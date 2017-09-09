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
        toggleText: "Don't have an account?",
        valid: true
      }
    },
    methods: {
      toggleForm() {
        this.login = !this.login;
        this.toggleText = this.login == true ? "Don't have an account?" : "Sign in Now"
      }
    }
  }
</script>
