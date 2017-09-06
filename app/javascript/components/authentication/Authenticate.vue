<template>
  <v-card>
    <v-card-title>
      <h4>Log In</h4>
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
  </v-card>
</template>


<script>
  export default {
    data() {
      return {
        email: '',
        password: '',
        password_confirmation: '',
        valid: true
      }
    }
  }
</script>
