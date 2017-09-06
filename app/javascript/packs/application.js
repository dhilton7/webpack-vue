/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import('../../../node_modules/vuetify/dist/vuetify.min.css')
import Vue from 'vue'
import Vuex from 'vuex'
import VueRouter from 'vue-router'
import App from './app.vue'
import Vuetify from 'vuetify'
import Dashboard from '../components/Dashboard.vue'
import Properties from '../components/Properties.vue'


Vue.use(Vuetify)
Vue.use(Vuex)
Vue.use(VueRouter)

const routes = [
  { path: '/', component: Dashboard },
  { path: '/properties', component: Properties }
]

const store = new Vuex.Store({
  state: {
    id: 1
  },
  mutations: {
    doSomething() {
      return state.id * 2
    }
  }
})

const router = new VueRouter({
  routes
});

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    store,
    router,
    render: h => h(App)
  })
})
