<template>
  <div class="bg-zinc-900 text-zinc-100">
    <main
      class="container mx-auto p-4 min-h-screen flex flex-col items-center justify-center"
    >
      <!-- Header -->
      <section class="flex flex-col items-center">
        <h1 class="text-4xl font-bold mb-4">Windsurf Installer</h1>
        <p class="text-lg text-zinc-400">
          A simple Bash script to install, update, and uninstall the Windsurf
          IDE on Linux
        </p>
      </section>

      <!-- Installation Steps -->
      <section class="flex flex-col mt-8 w-full max-w-4xl space-y-4">
        <div class="bg-zinc-800 rounded-lg p-4 font-mono">
          <div class="flex items-start">
            <span class="text-green-400 mr-2">$</span>
            <div class="flex-1">
              <span class="text-zinc-400"># Download the installer script</span>
              <div class="mt-1">
                <span class="text-blue-400">curl</span> -LO
                https://pyyupsk.github.io/windsurf-installer/install.sh
              </div>
            </div>
          </div>
        </div>

        <div class="bg-zinc-800 rounded-lg p-4 font-mono">
          <div class="flex items-start">
            <span class="text-green-400 mr-2">$</span>
            <div class="flex-1">
              <span class="text-zinc-400"># Make the script executable</span>
              <div class="mt-1">
                <span class="text-blue-400">chmod</span> +x install.sh
              </div>
            </div>
          </div>
        </div>

        <div class="bg-zinc-800 rounded-lg p-4 font-mono">
          <div class="flex items-start">
            <span class="text-green-400 mr-2">$</span>
            <div class="flex-1">
              <span class="text-zinc-400"># Run the installer</span>
              <div class="mt-1">
                <span class="text-blue-400">sudo</span> ./install.sh
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Features Grid -->
      <section class="mt-8 w-full max-w-4xl">
        <h2 class="text-2xl font-semibold mb-6">Features</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div class="bg-zinc-800 p-6 rounded-lg">
            <div class="text-4xl mb-3">🚀</div>
            <h3 class="text-xl font-semibold mb-2">Quick Installation</h3>
            <p class="text-zinc-400">Simple one-command installation process</p>
          </div>
          <div class="bg-zinc-800 p-6 rounded-lg">
            <div class="text-4xl mb-3">🔄</div>
            <h3 class="text-xl font-semibold mb-2">Easy Updates</h3>
            <p class="text-zinc-400">
              Keep your IDE up-to-date with a single command
            </p>
          </div>
          <div class="bg-zinc-800 p-6 rounded-lg">
            <div class="text-4xl mb-3">🧹</div>
            <h3 class="text-xl font-semibold mb-2">Clean Uninstall</h3>
            <p class="text-zinc-400">Remove all components completely</p>
          </div>
          <div class="bg-zinc-800 p-6 rounded-lg">
            <div class="text-4xl mb-3">🔒</div>
            <h3 class="text-xl font-semibold mb-2">Secure</h3>
            <p class="text-zinc-400">Verified and safe installation process</p>
          </div>
          <div class="bg-zinc-800 p-6 rounded-lg">
            <div class="text-4xl mb-3">💻</div>
            <h3 class="text-xl font-semibold mb-2">Linux Support</h3>
            <p class="text-zinc-400">
              Compatible with major Linux distributions
            </p>
          </div>
          <div class="bg-zinc-800 p-6 rounded-lg">
            <div class="text-4xl mb-3">⚡</div>
            <h3 class="text-xl font-semibold mb-2">Fast</h3>
            <p class="text-zinc-400">Optimized for quick setup and operation</p>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>
