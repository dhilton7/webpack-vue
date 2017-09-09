import('../../../node_modules/vuetify/dist/vuetify.min.css')
import Vue from 'vue'
import Vuetify from 'vuetify'

import Authenticate from '../components/authentication/Authenticate.vue'

Vue.use(Vuetify)


document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#authentication',
    render: h => h(Authenticate)
  })
})
