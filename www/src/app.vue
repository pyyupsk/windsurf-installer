<script setup lang="ts">
import { buttonVariants } from "./components/ui/button";
import AppBanner from "./components/AppBanner.vue";
import AppSnippet from "./components/AppSnippet.vue";
</script>

<template>
  <div class="flex h-screen flex-col overflow-auto">
    <!-- Top Banner -->
    <AppBanner />

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

        <AppSnippet code="curl -fsSL https://pyyupsk.is-a.dev/windsurf | sudo bash">
          <span class="text-primary">curl</span> -fsSL
          <span class="text-muted-foreground">https://pyyupsk.is-a.dev/windsurf</span> |
          <span class="text-primary">sudo</span> bash
        </AppSnippet>

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
