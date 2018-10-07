import "babel-polyfill"
import Vue from 'vue'
import axios from 'axios'
import store from '../common/vuex/index'
import components from './components/index'

// RoR の CSRF Token に対応
// axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].getAttribute('content')

document.addEventListener('DOMContentLoaded', function () {
    new Vue({
        el: '#app',
        store,
        components: components
    })
})
