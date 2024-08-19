---
slug: wang-editor-vue-3-rich-text-editor
title: wangEditor - Vue 3 Rich Text Editor (w/ Typescript)
description: In this article I'll show an interesting rich text editor that I found for Vue 3 and how to implement it in your next Vue 3 App.
publishedAt: 2023/11/22
---

> [wangEditor 5](https://www.wangeditor.com/en/) - Open source web rich text editor, run right out of the box, config simply.

---

## 1 - Install the dependencies:

Editor package:

```shell
yarn add @wangeditor/editor
# npm install @wangeditor/editor --save
```

Vue 3.x editor component:

```shell
yarn add @wangeditor/editor-for-vue@next
# npm install @wangeditor/editor-for-vue@next --save
```

In order to start using the editor we need to understand a few things before:

- In this case `@wangeditor/editor` will serve us some Typescript interfaces for typing our editor instance and more functionalities (read more on [wangEditor](https://www.wangeditor.com/en/v5/) docs).

- The `@wangeditor/editor-for-vue` will serve us the **Toolbar** and **Editor** components for use on a Vue 3 App.

## 2 - Coding the script and style

Let's start creating a component called `wangEditor.vue` and implementing the `script` and `style` sections.

`@/components/wangEditor.vue`

```vue
<template>
</template>

<script setup lang="ts">
import { onBeforeUnmount, shallowRef, reactive, toRefs } from "vue";
import { Editor, Toolbar } from "@wangeditor/editor-for-vue";
import {
  IDomEditor,
  IEditorConfig,
  IToolbarConfig,
} from "@wangeditor/editor";

const props = defineProps<{
  modelValue: string;
}>();

const emit = defineEmits<{
  (e: "update:modelValue", value: string): void;
}>();

// Editor instance shallowRef must be used
const editorRef = shallowRef<IDomEditor>();

const state = reactive({
  toolbarConfig: {} as IToolbarConfig,
  editorConfig: {
    placeholder: "Write something...",
    customAlert: () => {},
    scroll: true,
    readOnly: false,
    autoFocus: true,
    hoverbarKeys: {},
  } as IEditorConfig,
  defaultHtml: props.modelValue,
  mode: "default",
});

const { toolbarConfig, editorConfig, defaultHtml, mode } = toRefs(state);

const handleCreated = (editor: IDomEditor) => {
  editorRef.value = editor;
};

function handleChange(editor: IDomEditor) {
  emit("update:modelValue", editor.getHtml());
}

// When the component is destroyed, the editor is also destroyed in time.
onBeforeUnmount(() => {
  const editor = editorRef.value;
  if (editor == null) return;
  editor.destroy();
});
</template>

<style src="@wangeditor/editor/dist/css/style.css"></style>
```

## Explanation

1. Imports necessary functions and types from Vue and WangEditor libraries.
2.  Defines component props using `defineProps` for a model value.
3.  Defines component emits using `defineEmits` for updating the model value.
4.  Initializes a `shallowRef` for the WangEditor instance (editorRef).
5.  Defines a `reactive` state object (state) containing configurations for the toolbar, editor, default HTML content, and mode (refer to wangEditor doc [website] (https://www.wangeditor.com/en/v5/for-frame.html#vue3)).
7. Uses `toRefs` to create individual refs for the properties of the state object.
8. Defines a function (`handleCreated`) to be called when the editor is created, storing the editor instance in `editorRef`.
9. Defines a function (`handleChange`) to be called when the editor content changes, emitting an update to the model value.
10. Uses `onBeforeUnmount` to destroy the editor instance when the component is about to be unmounted.
11. Imports the WangEditor styles on `<style>` tag src prop.

## 3 - Coding the template (using wangEditor Vue Components)

`@/components/wangEditor.vue`

```vue
<template>
  <div
    style="border: 1px solid gray"
  >
    <Toolbar
      :editor="editorRef"
      :default-config="toolbarConfig"
      style="border-bottom: 1px solid gray;"
      :mode="mode"
    />
    <Editor
      v-model="defaultHtml"
      :default-config="editorConfig"
      style="height: 300px; overflow-y: hidden; border-radius: 20px"
      :mode="mode"
      @on-change="handleChange"
      @on-created="handleCreated"
    />
  </div>
</template>
```

1. `<Toolbar>` represents the top part of editor, all text formatter functions are here.
2. `<Editor>` represents the textarea section.
3. Each component has its own props and methods, so we simply need to bind them.

## Fullcode:

```vue
<script setup lang="ts">
import { onBeforeUnmount, reactive, shallowRef, toRefs } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import {
  IDomEditor,
  IEditorConfig,
  IToolbarConfig,
} from '@wangeditor/editor'

const props = defineProps<{
  modelValue: string
}>()

const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void
}>()

// Editor instance shallowRef must be used
const editorRef = shallowRef<IDomEditor>()

const state = reactive({
  toolbarConfig: {} as IToolbarConfig,
  editorConfig: {
    placeholder: 'Write something...',
    customAlert: () => {},
    scroll: true,
    readOnly: false,
    autoFocus: true,
    hoverbarKeys: {},
  } as IEditorConfig,
  defaultHtml: props.modelValue,
  mode: 'default',
})

const { toolbarConfig, editorConfig, defaultHtml, mode } = toRefs(state)

function handleCreated(editor: IDomEditor) {
  editorRef.value = editor
}

function handleChange(editor: IDomEditor) {
  emit('update:modelValue', editor.getHtml())
}

// When the component is destroyed, the editor is also destroyed in time.
onBeforeUnmount(() => {
  const editor = editorRef.value
  if (editor == null)
    return
  editor.destroy()
})
</script>

<template>
  <div
    style="border: 1px solid gray"
  >
    <Toolbar
      :editor="editorRef"
      :default-config="toolbarConfig"
      style="border-bottom: 1px solid gray;"
      :mode="mode"
    />
    <Editor
      v-model="defaultHtml"
      :default-config="editorConfig"
      style="height: 300px; overflow-y: hidden; border-radius: 20px"
      :mode="mode"
      @on-change="handleChange"
      @on-created="handleCreated"
    />
  </div>
</template>

<style src="@wangeditor/editor/dist/css/style.css"></style>
```
## How to exclude some menus from Toolbar?

On `toolbarConfig` object we can pass a `excludeKeys` array containing the keys of the menu items we want to remove:

```js
  toolbarConfig: {
    excludeKeys: [
      "headerSelect",
      "group-more-style",
      "fontFamily",
      "lineHeight",
      "group-indent",
      "insertLink",
      "group-image",
      "group-video",
      "insertTable",
      "codeBlock",
      "fullScreen",
    ],
  } as IToolbarConfig,
```

Refer to https://www.wangeditor.com/en/v5/toolbar-config.html#excludekeys for more info!

## How to exclude some menus from editor Hoverbar?

On the `editorConfig` object, we can pass a `text` object with a `menuKeys` array, specifying only the keys we want on the Hover Bar:

```js
  editorConfig: {
    placeholder: "Write something...",
    customAlert: () => {},
    scroll: true,
    readOnly: false,
    autoFocus: true,
    hoverbarKeys: {
      text: {
        menuKeys: [
          "blockquote",
          "bold",
          "through",
          "italic",
          "color",
          "bgColor",
          "bulletedList",
          "numberedList",
          "clearStyle",
        ],
      },
    },
  } as IEditorConfig,
```

Refer to https://www.wangeditor.com/en/v5/editor-config.html for more info!

## Usage

Now you just need to import your component inside any Vue file:

`@/views/EditorPage.vue`

```vue
<template>
  <div>
    <WangEditor v-model="text" />
  </div>
  <template>
    <script setup lang="ts">
      import { ref } from 'vue'
      import WangEditor from '@/components/wangEditor.vue'

      const text = ref<string>("")
    </script>
  </template>

  That's it!
</template>
```
