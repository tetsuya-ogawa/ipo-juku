import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    companies: ['testtttttttt']
  },
  getters: {
      companies: (state) => state.companies
  },
})