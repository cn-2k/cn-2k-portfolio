<script setup lang="ts">
const { t } = useI18n({
  useScope: 'local',
})

useSeoMeta({
  title: 'My projects',
  description: t('description'),
})

const projects = [
  {
    name: 'Nuxt Startup LP',
    link: 'https://nuxt-startup-landing-page.vercel.app/',
    github: 'https://github.com/cn-2k/nuxt-startup-landing-page',
    image: '/projects/nuxt-startup-lp.png',
    release: '2024',
  },
  {
    name: 'Nuxt SaaS LP',
    link: 'https://nuxt-saas-landing-page.vercel.app/',
    github: 'https://github.com/cn-2k/nuxt-saas-landing-page',
    image: '/projects/nuxt-saas-lp.png',
    release: '2024',
  },
  {
    name: 'WYSIWYG Editor',
    link: 'https://vue-tailwind-editor-demo.vercel.app/',
    github: 'https://github.com/cn-2k/vue-tailwind-wysiwyg-editor',
    image: '/projects/wysiwyg-editor.png',
    release: '2024',
  },
  {
    name: 'olhameucv',
    link: 'https://olhameucv.dev/',
    github: 'https://github.com/cn-2k/olhameucv.dev',
    image: '/projects/olhameucv.png',
    release: '2024',
  },
]
</script>

<template>
  <main>
    <AppTitle
      :description="t('description')"
      :title="t('title')"
    />
    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 mt-6">
      <ProjectCard
        v-for="project in projects"
        :key="project.name"
        :project
      />
    </div>
  </main>
</template>

<i18n lang="json">
{
  "en": {
  "title": "A list of projects I've worked on",
  "description": "Here you will find all my completed projects, including landing pages, components and much more. Feel free to view and explore them."
  },
  "pt": {
    "title": "Uma lista de projetos em que trabalhei",
    "description": "Aqui você encontrará todos os meus projetos já concluídos, incluindo landing pages, componentes e muito mais. Sinta-se à vontade para visualizá-los e explorá-los."
  }
}
</i18n>
