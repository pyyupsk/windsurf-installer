<script setup lang="ts">
import { useClipboard } from "@vueuse/core";
import { ArrowRight, Check, Copy, X } from "lucide-vue-next";
import { ref } from "vue";
import { buttonVariants } from "./components/ui/button";

const { copy, copied } = useClipboard();

const showBanner = ref<boolean>(true);
</script>

<template>
  <div class="flex h-screen flex-col overflow-auto">
    <!-- Top Banner -->
    <div v-if="showBanner" class="bg-gradient-to-r from-[#076c60] to-[#00a591] text-white">
      <div class="relative container flex h-9 items-center justify-center">
        <p class="text-sm font-medium">
          This is an unofficial community installer.
          <a href="#disclaimer" class="ml-1 inline-flex items-center underline">
            Read disclaimer <ArrowRight class="ml-1 h-3 w-3" />
          </a>
        </p>
        <button
          @click="showBanner = false"
          class="transforms absolute top-1/2 right-4 -translate-y-1/2"
        >
          <X class="h-4 w-4" />
        </button>
      </div>
    </div>

    <!-- Hero -->
    <div class="flex-1 py-20">
      <div class="container flex flex-col items-center justify-center gap-8">
        <img src="/windsurf.svg" alt="Windsurf Logo" class="mx-auto h-14 w-14" />
        <h1 class="text-6xl font-semibold tracking-tight">
          Windsurf IDE installer for <span class="font-serif">linux</span>
        </h1>
        <p class="max-w-5xl text-center text-2xl leading-8 tracking-tight">
          A simple Bash script to install, update, or uninstall the Windsurf IDE on Linux. Created
          by the
          <a
            href="https://github.com/pyyupsk"
            target="_blank"
            rel="noopener noreferrer"
            class="text-primary underline-offset-8 hover:underline"
            >@pyyupsk</a
          >
          to streamline Linux installation and management.
        </p>

        <div class="bg-card group relative mt-8 rounded-md px-8 py-4">
          <code class="overflow-x-auto whitespace-nowrap">
            <span class="text-primary">curl</span> -fsSL
            <span class="text-muted-foreground">https://pyyupsk.is-a.dev/windsurf</span> |
            <span class="text-primary">sudo</span> bash
          </code>

          <button
            :class="[
              'absolute top-1/2 right-4 -translate-y-1/2 cursor-pointer opacity-0 transition-opacity',
              copied ? 'opacity-100' : 'group-hover:opacity-100',
            ]"
            @click="copy('curl -fsSL https://pyyupsk.is-a.dev/windsurf | sudo bash')"
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

        <div class="mt-4 flex flex-col gap-4">
          <a :class="buttonVariants({ size: 'lg', class: 'px-12' })" href="#usage">
            Installation Flow
          </a>
          <a
            class="text-muted-foreground text-center text-sm"
            href="https://pyyupsk.is-a.dev/windsurf"
            target="_blank"
          >
            View script source
          </a>
        </div>

        <div class="border-muted-foreground/10 relative mt-8 overflow-hidden rounded-lg border-2">
          <img
            src="https://exafunction.github.io/public/images/windsurf/windsurf-ide-thumbnail.jpg"
            alt="Windsurf IDE Screenshot"
          />
        </div>
      </div>
    </div>
  </div>
</template>
