<template>
  <b-container>
    <b-row>
      <b-col>
        <h2>Top 100 URLs</h2>
        <ul style="list-style:none">
          <li v-for="item in items" :key="item._id">
            {{item.title}} -
            <a :href="item._id">{{baseUrl + item._id}}</a>
            - {{item.requests}} view{{item.requests > 1 ? "s" : ""}}
          </li>
        </ul>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import axios from "axios"

export default {
  data() {
    return {
      baseUrl: window.location.protocol + '//' + window.location.host + "/",
      items: []
    };
  },
  mounted() {
    axios({
      url: process.env.VUE_APP_API,
      method: "post",
      data: {
        query: `
          query top {
            top {
              _id
              title
              url
              requests
            }
          }
      `
      }
    }).then(result => {
      this.items = result.data.data.top;
    });
  }
};
</script>