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
    </v-card-text>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        email: '',
        password: ''
      }
    }
  }
</script>