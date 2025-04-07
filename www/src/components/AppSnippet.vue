<script setup lang="ts">
import { useClipboard } from "@vueuse/core";
import { Check, Copy } from "lucide-vue-next";
import AppCard from "./AppCard.vue";

const { copy, copied } = useClipboard();

defineProps<{ code: string }>();
</script>

<template>
  <AppCard class="mt-8">
    <div class="group relative px-8 py-4">
      <code class="overflow-x-auto whitespace-nowrap">
        <slot />
      </code>

      <button
        :class="[
          'absolute top-1/2 right-4 -translate-y-1/2 cursor-pointer opacity-0 transition-opacity',
          copied ? 'opacity-100' : 'group-hover:opacity-100',
        ]"
        @click="copy(code)"
      >
        <Copy
          :class="[
            'transforms absolute top-1/2 left-1/2 h-4 w-4 -translate-x-1/2 -translate-y-1/2 transition-all',
            copied ? 'scale-0 opacity-0' : 'scale-100 opacity-100',
          ]"
        />
        <Check
          :class="[
            'transforms absolute top-1/2 left-1/2 h-4 w-4 -translate-x-1/2 -translate-y-1/2 transition-all',
            copied ? 'scale-100 opacity-100' : 'scale-0 opacity-0',
          ]"
        />
      </button>
    </div>
  </AppCard>
</template>
