---
slug: how-scroll-to-specific-element-with-vue-js-3
title: How scroll to specific element with Vue.js 3
description: In this post I'll show how to scroll to specific element in Vue.js 3.
publishedAt: 2023/11/21
---

Sometimes, we need to make a scroll go to specific section/element of our page. Achieving this with Vue is very simple; you just need to use a [template ref](https://vuejs.org/guide/essentials/template-refs.html) for that. Let's see how to do it.

1 - Create a component template and give it a `ref` attribute:

```vue
<template>
 <main>
   <section ref="sectionRefEl">
     <some-component>element</some-component>
   </section>
 </main>
</template>
```

2 - Create the `script` section and declare your `ref` inside it:

```ts
<script setup lang="ts">
import { ref } from 'vue'

// Here is our template ref typed as HTMLElement or null
const sectionRefEl = ref<HTMLElement | null>(null)
</script>
```

3 - Create a function that make the scroll happen:

```ts
<script setup lang="ts">
import { ref } from 'vue'

// Here's our template ref typed as HTMLElement or null
const sectionRefEl = ref<HTMLElement | null>(null)

// Using scrollIntoView() function to achieve the scrolling
function scrollTo(view: Ref<HTMLElement | null>) { 
  view.value?.scrollIntoView({ behavior: 'smooth' }) 
}
</script>
```

The `scrollTo` function accepts a `ref` parameter and enables scrolling by using the `DOM API` function `scrollIntoView()`.

> Read more about the [scrollIntoView()](**https://developer.mozilla.org/pt-BR/docs/Web/API/Element/scrollIntoView**) function to learn more.

4 - Now you just need to call your function anywhere you want, passing a `ref` as param and see the scroll happening.

For example, you can create a button firing the method:

```ts
<template>
 <main>
   <section ref="sectionRefEl">
     <some-component>element</some-component>
   </section>
   <button @click="scrollTo(sectionRefEl)">Scroll to</button>
 </main>
</template>
```

And that's it!

**Further reading:**[Template Refs (Vuejs) ](https://vuejs.org/guide/essentials/template-refs.html#ref-on-component)[Element.scrollIntoView()](https://developer.mozilla.org/pt-BR/docs/Web/API/Element/scrollIntoView)
