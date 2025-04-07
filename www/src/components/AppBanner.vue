<script setup lang="ts">
import { ArrowRight } from "lucide-vue-next";
</script>

<template>
  <div class="sticky top-0 z-50 bg-gradient-to-r from-[#076c60] to-[#00a591] text-white">
    <div class="relative container flex h-9 items-center justify-center">
      <p class="text-sm font-medium">
        This is an unofficial community installer.
        <a href="#disclaimer" class="ml-1 inline-flex items-center underline">
          Read disclaimer <ArrowRight class="ml-1 h-3 w-3" />
        </a>
      </p>
    </div>
  </div>
  <div
    class="from-background/95 pointer-events-none fixed top-9 z-40 h-24 w-full bg-gradient-to-b to-transparent"
  />
</template>
