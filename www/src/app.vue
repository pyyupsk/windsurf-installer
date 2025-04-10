<script setup lang="ts">
import { buttonVariants } from "./components/ui/button";
import { Check, Download, Terminal, Monitor, Github } from "lucide-vue-next";
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
    <div class="container flex flex-col items-center justify-center gap-8 py-30">
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
        >
          @pyyupsk
        </a>
        to streamline Linux installation and management.
      </p>

      <AppSnippet code="curl -fsSL https://fasu.dev/windsurf | sudo bash">
        <span class="text-primary">curl</span> -fsSL
        <span class="text-muted-foreground">https://fasu.dev/windsurf</span> |
        <span class="text-primary">sudo</span> bash
      </AppSnippet>

      <div class="mt-4 flex flex-col gap-4">
        <a
          :class="
            buttonVariants({
              size: 'lg',
              class: 'shadow-primary/20 border-2 border-white/25 !px-12 !shadow-xl',
            })
          "
          href="https://github.com/pyyupsk/windsurf-installer"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Github />
          Star on GitHub
        </a>
        <a
          class="text-muted-foreground text-center text-sm"
          href="https://fasu.dev/windsurf"
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

    <!-- Disclaimer -->
    <div id="disclaimer" class="container py-20">
      <h2 class="text-center text-5xl font-semibold tracking-tight">Disclaimer</h2>
      <AppCard class="mt-8">
        <div class="flex flex-col gap-4 p-6">
          <p class="text-xl">
            <strong class="font-serif">
              This installation script for Windsurf IDE is not officially associated with, endorsed
              by, or affiliated with Windsurf (https://windsurf.com), the original developers of
              Windsurf IDE.
            </strong>
            This script is provided as an independent, third-party tool to facilitate installation
            of the software.
          </p>
          <p class="text-xl">
            The script is provided
            <strong class="font-serif">"as is" without warranty of any kind</strong>, either
            expressed or implied, including, but not limited to, the implied warranties of
            merchantability and fitness for a particular purpose.
            <strong class="font-serif">
              The entire risk as to the quality and performance of the script is with you.
            </strong>
          </p>
          <p class="text-xl">
            By using this installation script, you acknowledge that you are using an
            <strong class="font-serif">unofficial installation method</strong> and accept all
            associated risks. Please visit https://windsurf.com for official downloads and
            installation methods.
          </p>
        </div>
      </AppCard>
    </div>

    <!-- Footer -->
    <div class="border-t">
      <div class="container flex items-center justify-between py-4">
        <p class="text-muted-foreground text-sm">
          Made with ❤️ by
          <a
            href="https://github.com/pyyupsk"
            target="_blank"
            rel="noopener noreferrer"
            class="text-primary underline-offset-4 hover:underline"
          >
            @pyyupsk
          </a>
        </p>

        <div class="flex gap-4">
          <a href="#app" class="text-muted-foreground text-sm"> Back to Top </a>
          <a
            href="https://github.com/pyyupsk/windsurf-installer"
            target="_blank"
            rel="noopener noreferrer"
            class="text-muted-foreground text-sm"
          >
            GitHub
          </a>
          <a
            href="https://windsurf.com"
            target="_blank"
            rel="noopener noreferrer"
            class="text-muted-foreground text-sm"
          >
            Windsurf
          </a>
        </div>
      </div>
    </div>
  </div>
</template>
