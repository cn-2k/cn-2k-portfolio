<script setup lang="ts">
const { t } = useI18n({
  useScope: 'local',
})

const { locale, locales } = useI18n()
const currentLocale = computed(() => locales.value.find(l => l.code === locale.value) || { code: 'en' })

useSeoMeta({
  title: 'Blog',
  description: t('description'),
})

// Determine o caminho do conteúdo com base no idioma
const contentPath = computed(() => `/blog/${currentLocale.value.code}`)

const { data: writings } = await useAsyncData('all-writings', () =>
  queryContent(contentPath.value).sort({ published: -1 }).without('body').find())

const { data: writingsDB } = await useAsyncData('all-writings-db', () =>
  $fetch(`/api/posts`))

watch(
  () => currentLocale.value.code,
  async () => {
    await useAsyncData('all-writings', () =>
      queryContent(contentPath.value).sort({ published: -1 }).without('body').find())
  },
)

function getDetails(slug: string) {
  const writing = writingsDB.value?.find(w => w.slug === slug)
  if (!writing)
    return { views: 0, likes: 0 }
  return writing
}
</script>

<template>
  <main>
    <AppTitle
      :description="t('description')"
      :title="t('title')"
    />
    <ul class="mt-12 space-y-12">
      <li
        v-for="(writing, id) in writings"
        :key="id"
      >
        <NuxtLink
          :to="writing._path"
          class="group"
        >
          <article class="space-y-1">
            <p
              class="mb-0.5 text-sm text-neutral-500 group-hover:text-black dark:group-hover:text-white duration-300"
            >
              {{ useDateFormat(writing.publishedAt, 'DD MMMM YYYY', { locales: currentLocale!.code ?? 'en' }).value }}
            </p>
            <div class="flex items-center gap-2 flex-wrap">
              <h1
                class="font-bold text-lg duration-300 text-neutral-600 group-hover:text-black dark:text-neutral-400 dark:group-hover:text-white"
              >
                {{ writing.title }}
              </h1>
              <div class="flex gap-2">
                <span
                  class="items-center flex gap-1"
                >
                  <UIcon name="i-heroicons-eye" class="w-5 h-5" />
                  <p>{{ getDetails(writing.slug).views ?? 0 }}</p>
                </span>
                <p class="font-black">
                  ·
                </p>
                <span
                  class="items-center flex gap-1"
                >
                  <UIcon name="i-heroicons-heart-solid" class="w-5 h-5 text-red-500" />
                  <p>{{ getDetails(writing.slug).likes ?? 0 }}</p>
                </span>
              </div>
            </div>
            <h3>
              {{ writing.description }}
            </h3>
          </article>
        </NuxtLink>
      </li>
    </ul>
  </main>
</template>

<i18n lang="json">
{
  "en": {
    "title": "Here I share knowledge, experiences and tips.",
    "description": "I believe that sharing knowledge is the best way to learn; therefore, I dedicate this page to sharing my knowledge about all the technologies and topics in which I'm involved."
  },
  "pt": {
    "title": "Aqui compartilho conhecimento, experiências e dicas.",
    "description": "Acredito que compartilhar conhecimento é a melhor forma de aprender; por isso, dedico esta página para compartilhar meus conhecimentos sobre todas as tecnologias e assuntos nos quais estou envolvido."
  }
}
</i18n>
