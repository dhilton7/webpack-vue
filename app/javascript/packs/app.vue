<template>
  <v-app id="example-1" toolbar footer>
    <v-navigation-drawer
      persistent
      v-model="drawer"
      light
      enable-resize-watcher
      overflow
    >
    <v-list>
      <v-list-tile @click="">
        <v-list-tile-action>
          <v-icon>home</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <router-link to="/"><v-list-tile-title>Home</v-list-tile-title></router-link>
        </v-list-tile-content>
      </v-list-tile>
      <v-list-tile @click="">
        <v-list-tile-action>
          <v-icon>list</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <router-link to="/properties"><v-list-tile-title>Properties</v-list-tile-title></router-link>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-navigation-drawer>
  <v-toolbar class="indigo" dark>
    <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
  <v-toolbar-title>Toolbar</v-toolbar-title>
</v-toolbar>
<main>
  <v-container fluid>
    <!--v-router-->
    <router-view></router-view>
  </v-container>
</main>
</v-app>
</template>

<script>
export default {
  data () {
    return {
      drawer: true
    }
  }
}
</script>