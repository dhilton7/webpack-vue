<template>
  <div>
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
  </div>
</template>

<script>
  export default {
    data() {
      return {
        drawer: true,
        items: [
          { id: 1, name: 'Home', icon: 'home', route: '/' },
          { id: 2, name: 'Properties', icon: 'list', route: '/properties' }
        ]
      }
    },
    methods: {
      doWork() {
        console.log('do it')
      }
    }
  }
</script>