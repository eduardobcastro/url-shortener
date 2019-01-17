<template>
  <b-container id="app">
    <b-row>
      <b-col>
        <h1>URL Shortener</h1>
        <Shortener />
        <br>
        <br>
        <TopURLs />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Vue from 'vue'
import Shortener from './components/Shortener.vue'
import TopURLs from './components/TopURLs.vue'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)

export default {
  name: 'App',
  components: {
    Shortener,
    TopURLs
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
