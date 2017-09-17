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
        <v-list-tile v-for="(item, index) in items" :key="index" :to="item.route">
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
      </v-toolbar-title>
      <v-spacer></v-spacer>
    </v-toolbar>

    <main>
      <v-container fluid grid-list-md>
        <router-view></router-view>
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
          { id: 1, name: 'Home', icon: 'home', route: '/home' },
          { id: 2, name: 'Properties', icon: 'view_list', route: '/properties' },
          { id: 3, name: 'Financials', icon: 'attach_money', route: '/financials'},
          { id: 4, name: 'Analyze', icon: 'insert_chart', route: '/analyze' }
        ]
      }
    }
  }
</script>

<style>
</style>