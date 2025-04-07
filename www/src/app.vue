<script setup lang="ts">
import { buttonVariants } from "./components/ui/button";
import { Check, Download, Terminal, Monitor } from "lucide-vue-next";
import AppBanner from "./components/AppBanner.vue";
import AppSnippet from "./components/AppSnippet.vue";
import AppCard from "./components/AppCard.vue";

const features = [
  {
    title: "Latest Version",
    description: "Install or update to the latest version of Windsurf IDE automatically",
    icon: Download,
  },
  {
    title: "Verified Downloads",
    description: "Verifies downloads using SHA256 checksums for security",
    icon: Check,
  },
  {
    title: "Desktop Integration",
    description: "Automatically creates desktop integration with icon and launcher",
    icon: Monitor,
  },
  {
    title: "Clean Logs",
    description:
      "Informative logs with success <span class='text-green-500'>[✓]</span>, errors <span class='text-red-500'>[✗]</span>, and information <span class='text-blue-500'>[+]</span>",
    icon: Terminal,
  },
];
</script>

<template>
  <div class="flex h-screen flex-col">
    <!-- Top Banner -->
    <AppBanner />

    <!-- Hero -->
    <div class="container flex flex-col items-center justify-center gap-8 py-20">
      <img src="/windsurf.svg" alt="Windsurf Logo" class="mx-auto h-14 w-14" />
      <h1 class="text-6xl font-semibold tracking-tight">
        Windsurf IDE installer for <span class="font-serif">linux</span>
      </h1>
      <p class="max-w-5xl text-center text-2xl leading-8 tracking-tight">
        A simple Bash script to install, update, or uninstall the Windsurf IDE on Linux. Created by
        the
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
        <a
          :class="buttonVariants({ size: 'lg', class: 'shadow-primary/20 px-12 !shadow-xl' })"
          href="#usage"
        >
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

      <AppCard class="mt-8" variant="gradient">
        <img
          src="https://exafunction.github.io/public/images/windsurf/windsurf-ide-thumbnail.jpg"
          alt="Windsurf IDE Screenshot"
        />
      </AppCard>
    </div>

    <!-- Features -->
    <div class="container py-20">
      <h2 class="text-5xl font-semibold tracking-tight">
        Features: <br />
        Unlock the Full Potential of Your Space
      </h2>
      <div class="mt-8 grid grid-cols-2 gap-4">
        <AppCard v-for="feature in features" :key="feature.title">
          <div class="flex gap-4 p-6">
            <div
              class="bg-primary/20 text-primary flex h-10 w-10 items-center justify-center rounded-md"
            >
              <component :is="feature.icon" class="h-6 w-6" />
            </div>
            <div class="flex-1">
              <h3 class="text-lg leading-7 font-semibold tracking-tight">
                {{ feature.title }}
              </h3>
              <p
                class="text-muted-foreground mt-2 text-sm leading-6"
                v-html="feature.description"
              />
            </div>
          </div>
        </AppCard>
      </div>
    </div>
  </div>
</template>
