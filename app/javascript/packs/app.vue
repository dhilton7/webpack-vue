<template>
  <v-app
    id="e3"
    standalone
    toolbar
  >
    <v-navigation-drawer
      persistent
      clipped
      enable-resize-watcher
      v-model="drawer"
    >
      <v-list dense>
        <v-list-tile v-for="item in items" :key="item.id">
          <v-list-tile-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
          <v-list-tile-title>{{ item.name }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar class="green lighten-1">
      <v-toolbar-title>
        <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
        <v-icon>fa-youtube</v-icon>
      </v-toolbar-title>
      <v-spacer></v-spacer>
    </v-toolbar>
    <main>
      <v-container fluid>
        <v-layout>
          <router-view></router-view>
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
        { id: 1, name: 'Home', icon: 'home' },
        { id: 2, name: 'Properties', icon: 'list' }
      ]
    }
  }
}
</script>

<style>
</style>