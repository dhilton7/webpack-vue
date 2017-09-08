<template>
  <v-app
    height="415px"
    id="e3"
    standalone
    toolbar
  >
    <v-navigation-drawer
      persistent
      absolute
      height="100%"
      clipped
      enable-resize-watcher
      v-model="drawer"
    >
    <v-list dense>
      <v-list-tile v-for="item in items">
      <v-list-tile-action>
        <v-icon>{{ item.icon }}</v-icon>
      </v-list-tile-action>
      <v-list-tile-content>
        <v-list-tile-title>{{ item.name }}</v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>
    </v-list>
  </v-navigation-drawer>
<v-toolbar class="red">
  <v-toolbar-title>
    <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
  <v-icon class="ml-3">fa-youtube</v-icon>
</v-toolbar-title>
<v-spacer></v-spacer>
</v-toolbar>
<main>
  <v-container>
    <v-layout>
      <v-flex xs12>
        <router-view></router-view>
      </v-flex>
    </v-layout>
  </v-container>
</main>
</v-app>
</template>

<script>
  export default {
  data() {
    return {
      drawer: true,
      items: [
        { name: 'Home', icon: 'home' },
        { name: 'Properties', icon: 'list' }
      ]
    }
  }
}
</script>

<style>
</style>