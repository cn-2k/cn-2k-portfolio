<script setup lang="ts">
const socials = [
  {
    icon: 'i-mdi-linkedin',
    label: 'LinkedIn',
    link: 'https://www.linkedin.com/in/caio-2k/',
  },
  {
    icon: 'i-mdi-github',
    label: 'GitHub',
    link: 'https://github.com/cn-2k',
  },
  {
    icon: 'i-ph-x-logo',
    label: 'Twitter',
    link: 'https://x.com/caionic2k',
  },
]

const { t } = useI18n({
  useScope: 'local',
})
</script>

<template>
  <footer class="my-14">
    <div class="flex justify-center mb-5">
      <UDivider :label="t('find')" />
    </div>

    <div class="flex gap-3 w-full justify-center">
      <div v-for="social in socials" :key="social.label">
        <UTooltip
          :text="social.label"
        >
          <UButton
            :icon="social.icon"
            color="white"
            :aria-label="social.label"
            size="xl"
            variant="solid"
            :to="social.link"
            target="_blank"
          />
        </UTooltip>
      </div>
    </div>

    <div class="mt-8 w-full flex justify-center text-xs">
      {{
        t('copyright', {
          date: new Date().getFullYear(),
        })
      }}
    </div>
  </footer>
</template>

<i18n lang="json">
{
  "en": {
    "find": "Find me on:",
    "copyright": "© {date} Caio Vinicius. All rights reserved."
  },
  "pt": {
    "find": "Encontre-me em:",
    "copyright": "© {date} Caio Vinicius. Todos os direitos reservados."
  }
}
</i18n>
