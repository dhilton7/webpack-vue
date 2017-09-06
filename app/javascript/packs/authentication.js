import('../../../node_modules/vuetify/dist/vuetify.min.css')
import Vue from 'vue'
import VueRouter from 'vue-router'
import Vuetify from 'vuetify'

import Authenticate from '../components/authentication/Authenticate.vue'

Vue.use(Vuetify)
Vue.use(VueRouter)

const routes = [
  { path: '/login', components: Authenticate }
]

const router = new VueRouter({
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#authentication',
    router,
    render: h => h(Authenticate)
  })
})
