<template>
  <b-container>
    <b-row>
      <b-col>
        <b-input-group>
          <b-form-input
            v-model="url"
            type="text"
            placeholder="http://www.example.com"
            @keydown.native="urlKeyDown"
          />
          <b-input-group-append>
            <b-btn variant="primary" @click="shortenUrl">Shorten</b-btn>
          </b-input-group-append>
        </b-input-group>
        <br>
        <b-alert :show="error != ''" variant="danger">{{error}}</b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col v-if="shorten && !error">
        <br>Shorten URL for
        <strong>{{url}}</strong> is
        <a :href="shorten">{{shorten}}</a>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import axios from "axios";
import util from "../util";

export default {
  data() {
    return {
      url: "",
      shorten: "",
      error: ""
    };
  },
  methods: {
    urlKeyDown(event) {
      this.shorten = ""
      if (event.which === 13) {
        this.shortenUrl()
      }
    },
    async shortenUrl() {
      if (!this.url.startsWith('http://') && !this.url.startsWith('https://')) {
        this.url = 'http://' + this.url
      }
      if (!util.isURL(this.url)) {
        this.error = "Invalid URL"
        return
      }
      let result = await axios({
        url: "http://localhost:3000/graphql",
        method: "post",
        data: {
          query: `
          mutation shorten($url: String) {
            shorten(url: $url) {
              _id
            }
          }
        `,
          operationName: "shorten",
          variables: { url: this.url }
        }
      });
      if (result.data.errors) {
        this.error = result.data.errors[0].message
        return
      }
      this.shorten = window.location.protocol + '//' + window.location.host + "/" + result.data.data.shorten._id
      this.error = ""
    }
  }
};
</script>