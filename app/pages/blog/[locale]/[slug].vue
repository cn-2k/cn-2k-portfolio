<script lang="ts" setup>
const route = useRoute()
const { locale, locales } = useI18n()

const contentPath = computed(() => `/blog/${locale.value}/${route.params.slug}`)

const { data: post } = await useAsyncData(`writing:${route.params.slug}`, () =>
  queryContent(contentPath.value).findOne())

watch(
  () => locale.value,
  async () => {
    await useAsyncData(`writing:${route.params.slug}`, () =>
      queryContent(contentPath.value).findOne())
  },
)

const {
  data: postDB,
  refresh,
} = await useAsyncData(`writing:${route.params.slug}:db`, () => $fetch(`/api/posts/${route.params.slug}`, { method: 'POST' }))

const currentLocale = computed(() => locales.value.filter(l => l.code === locale.value)[0])

const { t } = useI18n({
  useScope: 'local',
})

function top() {
  window.scrollTo({
    top: 0,
    left: 0,
    behavior: 'smooth',
  })
}

const { copy, copied } = useClipboard({
  source: `https://cn-2k.vercel.app/blog/${route.params.slug}`,
  copiedDuring: 4000,
})

useSeoMeta({
  title: post.value?.title,
  description: post.value?.description,
  author: 'Caio Vinicius',
})

const likeCookie = useCookie<boolean>(`post:like:${route.params.slug}`, {
  maxAge: 7200,
})

async function handleLike() {
  if (likeCookie.value)
    return
  await $fetch(`/api/posts/like/${route.params.slug}`, { method: 'PUT' })
  await refresh()
  likeCookie.value = true
}
</script>

<template>
  <main v-if="post && postDB">
    <div class="flex">
      <NuxtLinkLocale
        class="flex items-center gap-2 mb-8 group text-sm hover:text-black dark:hover:text-white duration-300"
        to="/blog"
      >
        <UIcon
          class="group-hover:-translate-x-1 transform duration-300"
          name="i-heroicons-arrow-left"
          size="20"
        />
        {{ t('back') }}
      </NuxtLinkLocale>
    </div>
    <p class="text-sm text-neutral-500">
      {{ useDateFormat(post.publishedAt, 'DD MMMM YYYY', { locales: currentLocale!.code ?? 'en' }).value }}
    </p>
    <div class="mt-2">
      <div class="flex items-end gap-2 flex-wrap">
        <h1
          class="font-bold text-3xl text-black dark:text-white"
        >
          {{ post.title }}
        </h1>
        <div class="flex gap-2">
          <span
            class="items-center flex gap-1"
          >
            <UIcon name="i-heroicons-eye" class="w-5 h-5" />
            <p>{{ postDB.views }}</p>
          </span>
          <p class="font-black">
            ·
          </p>
          <span
            class="items-center flex gap-1"
          >
            <UIcon name="i-heroicons-heart-solid" class="w-5 h-5 text-red-500" />
            <p>{{ postDB.likes }}</p>
          </span>
        </div>
      </div>
      <p class="mt-4 text-base">
        {{ post.description }}
      </p>
    </div>
    <div
      v-if="post.cover"
      class="w-full rounded-md my-8"
    >
      <NuxtImg
        :src="`/blog/${post.cover}`"
        alt="Article cover"
      />
    </div>
    <UDivider
      class="mt-8"
      icon="i-ph-pencil-line-duotone"
    />
    <article class="mt-8">
      <ContentRenderer :value="post">
        <ContentRendererMarkdown
          :value="post"
          class="!max-w-none prose dark:prose-invert"
        />
      </ContentRenderer>
      <div class="mt-10">
        <div class="flex gap-4 items-center flex-wrap">
          <UButton
            :label="postDB?.likes > 1 ? `${postDB?.likes} likes` : `${postDB?.likes} like`"
            :color="likeCookie ? 'red' : 'white'"
            icon="i-heroicons-heart"
            size="lg"
            variant="solid"
            @click.prevent="handleLike()"
          />
          <UButton
            color="white"
            icon="i-heroicons-arrow-up-circle"
            :label="t('top')"
            size="lg"
            variant="solid"
            @click.prevent="top()"
          />
          <UButton
            v-if="copied"
            color="green"
            icon="i-heroicons-check-circle"
            :label="t('link.copied')"
            size="lg"
            variant="outline"
            @click.prevent="copy()"
          />
          <UButton
            v-else
            color="white"
            icon="i-heroicons-share"
            :label="t('link.copy')"
            size="lg"
            variant="solid"
            @click.prevent="copy()"
          />
        </div>
      </div>
    </article>
  </main>
</template>

<style>
.prose h2 a,
.prose h3 a,
.prose h4 a {
  @apply no-underline;
}
</style>

<i18n lang="json">
{
  "en": {
    "likes": {
      "one": "like",
      "many": "likes"
    },
    "views": {
      "one": "view",
      "many": "views"
    },
    "alert": {
      "title": "Translations alert!",
      "description": "Due to time constraints, all article translations will be available only in English. Thank you for your understanding."
    },
    "thanks": "Thanks for reading this post! If you liked it, please consider sharing it with your friends. {like}",
    "like": "Don't forget to leave a like!",
    "link": {
      "copied": "Link copied",
      "copy": "Copy link"
    },
    "top": "Go to top",
    "back": "Go back"
  },
  "pt": {
    "likes": {
      "one": "like",
      "many": "likes"
    },
    "views": {
      "one": "visualização",
      "many": "visualizações"
    },
    "link": {
      "copied": "Link copiado!",
      "copy": "Compartilhar link"
    },
    "top": "Ir para o topo",
    "back": "Voltar"
  }
}
</i18n>
