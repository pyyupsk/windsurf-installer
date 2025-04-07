<script setup lang="ts">
import type { HTMLAttributes } from "vue";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const cardVariants = cva("overflow-hidden rounded-lg", {
  variants: {
    variant: {
      default: "bg-[linear-gradient(rgba(91,_89,_89,_0.5)_0%,_rgba(91,_89,_89,_0.27)_98.4%)] p-px",
      gradient: "bg-[radial-gradient(ellipse_at_center,_#ffffff0d_85%,_#09B6A240)] p-0.5",
    },
  },
  defaultVariants: {
    variant: "default",
  },
});

type CardVariants = VariantProps<typeof cardVariants>;

interface Props {
  variant?: CardVariants["variant"];
  class?: HTMLAttributes["class"];
}

const props = withDefaults(defineProps<Props>(), {
  variant: "default",
});
</script>

<template>
  <div :class="cn(cardVariants({ variant: props.variant }), props.class)">
    <div
      class="relative overflow-hidden rounded-lg"
      :style="{
        background:
          props.variant === 'default'
            ? 'radial-gradient(circle at 20% 15%, rgba(115, 115, 115, 0.15) 5%, transparent 50%), linear-gradient(rgb(13, 14, 15) 0%, rgb(13, 14, 15) 98.4%)'
            : 'bg-card',
      }"
    >
      <slot />
    </div>
  </div>
</template>
