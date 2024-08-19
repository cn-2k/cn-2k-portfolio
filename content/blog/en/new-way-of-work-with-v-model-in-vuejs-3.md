---
slug: new-way-of-work-with-v-model-in-vuejs-3
title: New way of work with V-Model in Vue.js 3!
description: Check in this article how to use this new feature of Vue!
publishedAt: 2024/01/09
---

Vue.js `3.4` release introduces the new `defineModel()` macro, which is now **stable**! With it you can create `v-model` without writing `props` and `emits` for each one.

**Previous way** (Vue.js `3.3-`):

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

**New Way** (Vue.js `3.4+`):

```vue
<script setup>
const model = defineModel()
</script>

<template>
  <input v-model="model">
</template>
```

Very clean, right?

You can also type your `v-model`:

```ts
const model = defineModel<string>()
```

## Points to note:

- The value returned by `defineModel()` is a `ref` so you can access and mutate the value.
- Keep in mind that `defineModel()` is a macro, so under the hood, everything is the same as in the previous version.

Make sure to read the Vue 3 docs for more info about the `defineModel()` usage:

https://vuejs.org/api/sfc-script-setup.html#definemodel

https://vuejs.org/guide/components/v-model#basic-usage
