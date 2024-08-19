---
slug: new-way-of-work-with-v-model-in-vuejs-3
title: Nova forma de trabalhar com o v-model no Vue 3!
description: Confira neste artigo como usar esse novo recurso do Vue!
publishedAt: 2024/01/09
---

A versão `3.4` do Vue introduz o novo macro `defineModel()`, que agora se encontra **stable**! Com ele você consegue criar `v-model` sem precisar criar `props` e `emits`.

**Forma anterior** (Vue.js `3.3-`):

```vue
<script setup>
const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])
</script>

<template>
  <input
    :value="props.modelValue"
    @input="emit('update:modelValue', $event.target.value)"
  >
</template>
```

**Nova forma** (Vue.js `3.4+`):

```vue
<script setup>
const model = defineModel()
</script>

<template>
  <input v-model="model">
</template>
```

Bem limpo, né?

Você também consegue tipar o `v-model`:

```ts
const model = defineModel<string>()
```

## Pontos a considerar:

- O valor retornado pelo `defineModel()` é uma `ref` portanto você consegue acessar e mutar o seu valor.
- Mantenha em mente que `defineModel()` um macro, ou seja, por debaixo dos panos o comportamento é o mesmo que a versão anterior.

Certifique-se de ler a documentação oficial do Vue 3 para mais informações sobre o uso do `defineModel()`:

https://vuejs.org/api/sfc-script-setup.html#definemodel

https://vuejs.org/guide/components/v-model#basic-usage
