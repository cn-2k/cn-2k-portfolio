<script setup lang="ts">
const colorMode = useColorMode()

const isDark = ref(colorMode.value === 'dark')

watch(isDark, () => {
  colorMode.preference = colorMode.value === 'dark' ? 'light' : 'dark'
})

const links: any = [{
  label: {
    en: 'About',
    pt: 'Sobre',
  },
  icon: 'i-heroicons-user-circle',
  to: '/',
}, {
  label: {
    en: 'Projects',
    pt: 'Projetos',
  },
  icon: 'i-heroicons-code-bracket',
  to: '/projects',
}, {
  label: {
    en: 'Blog',
    pt: 'Blog',
  },
  icon: 'i-heroicons-pencil-square',
  to: '/blog',
}]

async function toggleTheme() {
  isDark.value = !isDark.value
}

const { locale, setLocale, locales, t } = useI18n()
const currentLocale = computed(() => locales.value.filter(l => l.code === locale.value)[0])

async function changeLocale() {
  await setLocale(locale.value === 'en' ? 'pt' : 'en')
}

const router = useRouter()

defineShortcuts({
  t: () => toggleTheme(),
  l: () => changeLocale(),
  backspace: () => router.back(),
})
</script>

<template>
  <header class="flex flex-col md:flex-row items-center justify-between my-8 gap-4 md:gap-0 select-none">
    <NuxtLinkLocale
      class="handwriting items-center justify-center text-xl sm:text-3xl flex gap-2 font-bold duration-300 text-gray-600 hover:text-black dark:text-gray-400 dark:hover:text-white"
      to="/"
    >
      <UAvatar
        size="lg"
        src="https://avatars.githubusercontent.com/u/59366705?v=4"
        alt="Avatar"
      />
      Caio Vinicius
    </NuxtLinkLocale>
    <div class="flex gap-2 items-center">
      <UHorizontalNavigation :links="links" class="w-fit">
        <template #default="{ link }">
          <span class="group-hover:text-black dark:group-hover:text-white relative">{{ link.label[locale] }}</span>
        </template>
      </UHorizontalNavigation>
      <ClientOnly>
        <UTooltip
          :shortcuts="['t']"
          :text="t('theme')"
        >
          <UButton
            :icon="isDark ? 'i-heroicons-moon-solid' : 'i-heroicons-sun'"
            color="white"
            aria-label="switch theme"
            size="sm"
            variant="solid"
            @click="toggleTheme()"
          />
        </UTooltip>
        <UTooltip
          :shortcuts="['l']"
          :text="t('language')"
        >
          <UButton
            color="white"
            aria-label="switch language"
            size="sm"
            variant="solid"
            class="font-bold text-gray-700"
            @click.prevent="changeLocale()"
          >
            {{ currentLocale?.code === 'en' ? 'pt' : 'en' }}
          </UButton>
        </UTooltip>
      </ClientOnly>
    </div>
  </header>
</template>

<style>
.handwriting {
  font-family: 'Satisfy', cursive;
}
</style>

<i18n lang="json">
{
  "en": {
    "theme": "switch theme",
    "language": "change language"
  },
  "pt": {
    "theme": "Alterar o tema",
    "language": "Alterar o idioma"
  }
}
</i18n>
