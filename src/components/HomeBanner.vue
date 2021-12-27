<template functional>
  <div class="banner">
    <div class="container">
      <h1 class="logo-font">Hello Kostya :) </h1>
      <img src="Kostya.png">
      <p>A place to share your knowledge.</p>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component
export default class HomeBanner extends Vue {}
</script>
