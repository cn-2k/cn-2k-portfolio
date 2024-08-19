<script lang="ts" setup>
const { t } = useI18n({
  useScope: 'local',
})

const skills = [
  {
    name: 'Typescript',
    icon: 'i-logos-typescript-icon',
    link: 'https://www.typescriptlang.org/',
  },
  {
    name: 'Vue.js',
    icon: 'i-logos-vue',
    link: 'https://vuejs.org/',
  },
  {
    name: 'Nuxt',
    icon: 'i-logos-nuxt-icon',
    link: 'https://nuxt.com/',
  },
  {
    name: 'Vite',
    icon: 'i-logos-vitejs',
    link: 'https://vitejs.dev/',
  },
  {
    name: 'TailwindCSS',
    icon: 'i-logos-tailwindcss-icon',
    link: 'https://tailwindcss.com/',
  },
  {
    name: 'Cypress',
    icon: 'i-simple-icons-cypress',
    link: 'https://www.cypress.io/',
  },
  {
    name: 'Postman',
    icon: 'i-logos-postman-icon',
    link: 'https://www.postman.com/',
  },
  {
    name: 'Insomnia',
    icon: 'i-logos-insomnia',
    link: 'https://insomnia.rest/',
  },
  {
    name: 'Git',
    icon: 'i-logos-git-icon',
    link: 'https://git-scm.com/',
  },
  {
    name: 'Github',
    icon: 'i-mdi-github',
    link: 'https://github.com/',
  },
  {
    name: 'VSCode',
    icon: 'i-logos-visual-studio-code',
    link: 'https://code.visualstudio.com/',
  },
  {
    name: 'Trello',
    icon: 'i-logos-trello',
    link: 'https://trello.com/',
  },
]

const wantToLearn = [
  {
    name: 'React',
    icon: 'i-logos-react',
    link: 'https://react.dev/',
  },
  {
    name: 'Angular',
    icon: 'i-logos-angular-icon',
    link: 'https://angular.dev/',
  },
  {
    name: 'Go',
    icon: 'i-logos-go',
    link: 'https://go.dev/',
  },
  {
    name: 'Laravel',
    icon: 'i-logos-laravel',
    link: 'https://laravel.com/',
  },
  {
    name: 'Docker',
    icon: 'i-logos-docker-icon',
    link: 'https://www.docker.com/',
  },
  {
    name: 'Node.js',
    icon: 'i-logos-nodejs-icon',
    link: 'https://nodejs.org/pt',
  },
  {
    name: 'GraphQL',
    icon: 'i-logos-graphql',
    link: 'https://graphql.org/',
  },
]
</script>

<template>
  <p class="">
    {{ t('actually') }}
  </p>
  <div class="flex flex-wrap gap-3 w-full justify-center">
    <div v-for="skill in skills" :key="skill.name">
      <UTooltip
        :text="skill.name"
      >
        <UButton
          :icon="skill.icon"
          color="white"
          :aria-label="skill.name"
          size="xl"
          variant="solid"
          :to="skill.link"
          target="_blank"
        />
      </UTooltip>
    </div>
  </div>

  <p class="">
    {{ t('want') }}
  </p>
  <div class="flex flex-wrap gap-3 w-full justify-center">
    <div v-for="skill in wantToLearn" :key="skill.name">
      <UTooltip
        :text="skill.name"
      >
        <UButton
          :icon="skill.icon"
          color="white"
          :aria-label="skill.name"
          size="xl"
          variant="solid"
          :to="skill.link"
          target="_blank"
        />
      </UTooltip>
    </div>
  </div>
</template>

<i18n lang="json">
  {
    "en": {
      "actually": "Actually working with:",
      "want": "Want to learn:"
    },
    "pt": {
      "actually": "Atualmente trabalhando com:",
      "want": "Interesse em aprender:"
    }
  }
  </i18n>
