---
slug: how-scroll-to-specific-element-with-vue-js-3
title: Como rolar para um componente específico no Vue.js 3
description: Nesse post eu vou te mostrar como scrollar para um componente específico no Vue.js 3.
publishedAt: 2023/11/21
---

Às vezes, precisamos fazer um scroll para uma seção/elemento específico da nossa página. Conseguir isso com Vue é muito simples; você só precisar usar uma [template ref](https://vuejs.org/guide/essentials/template-refs.html) para isso. Vamos ver como fazer isso.

1 - Crie um template de componente e adicione a ele um atributo `ref`:

```vue
<template>
  <main>
    <section ref="sectionRefEl">
      <some-component>element</some-component>
    </section>
  </main>
</template>
```

2 - Crie a seção `script` e declare sua `ref` dentro dela:

```vue
<script setup lang="ts">
import { ref } from 'vue'

// Here is our template ref typed as HTMLElement or null
const sectionRefEl = ref<HTMLElement | null>(null)
</script>
```

3 - Crie uma função que faz com que o scroll aconteça:

```vue
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

A função `scrollTo` aceita um parâmetro `ref` e permite o scroll usando a função `scrollIntoView()` da `DOM API`.

> Leia mais sobre a função [scrollIntoView()](**https://developer.mozilla.org/pt-BR/docs/Web/API/Element/scrollIntoView**) para saber mais.

4 - Agora você só precisa chamar sua função em qualquer lugar que desejar, passando uma `ref` como parâmetro e ver o scroll acontecendo.

Por exemplo, você pode criar um botão que executa o método:

```vue
<template>
  <main>
    <section ref="sectionRefEl">
      <some-component>element</some-component>
    </section>
    <button @click="scrollTo(sectionRefEl)">
      Scroll to
    </button>
  </main>
</template>
```

E é isso!

**Leitura complementar:**

[Template Refs (Vuejs) ](https://vuejs.org/guide/essentials/template-refs.html#ref-on-component)

[Element.scrollIntoView()](https://developer.mozilla.org/pt-BR/docs/Web/API/Element/scrollIntoView)
