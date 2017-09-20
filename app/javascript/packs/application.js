/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// CSS
import('../../../node_modules/vuetify/dist/vuetify.min.css')

// Libraries
import Vue from 'vue'
import Vuex from 'vuex'
import VueRouter from 'vue-router'
import Vuetify from 'vuetify'

// Components
import App from './app.vue'
import Analyze from '../components/Analyze.vue'
import Dashboard from '../components/Dashboard.vue'
import Properties from '../components/Properties.vue'
import Financials from '../components/financials/Financials.vue'
import FinancialDetails from '../components/financials/Details.vue'


Vue.use(Vuetify)
Vue.use(Vuex)
Vue.use(VueRouter)

const routes = [
  { path: '/home', component: Dashboard },
  { path: '/properties', component: Properties },
  { path: '/financials', component: Financials },
  { path: '/analyze', component: Analyze },
  { path: '/financials/:id', component: FinancialDetails }
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
