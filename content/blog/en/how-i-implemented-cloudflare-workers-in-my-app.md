---
slug: how-i-implemented-cloudflare-workers-in-my-app
title: How I implemented Cloudflare Workers in my App
description: In this post I'll show how I implemented Cloudflare Workers in my App
publishedAt: 2024/04/14
---

## What I Built
Nottia is a Nuxt 3 simple app that you can generate notes, dont forget your ideas, just create a note! xD

In this app you also have the option to generate notes by sending prompts to an AI and receiving a response based on that prompt.

**Generating a note based on user prompt:**
![Note generation](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/494s8ppfpcaq8gtcy64c.gif)

**Generating a image based on user prompt:**
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ithtq45kp8tm5ajdbblp.gif)

## Demo

See the demo right here:

On Cloudflare Pages:
https://nottia.pages.dev/

On Vercel:
https://nottia.vercel.app/

## My Code

The source code of the app was split in two repositories: one for the front-end and another for the Cloudflare Worker.

**Nottia:**

https://github.com/cn-2k/nottia

**Nottia Worker:**

https://github.com/cn-2k/nottia-worker

## Journey

Initially this app was focused on register notes manually, with this challenge I saw the oportunitty for delve deeper into AI, Serverless Workers, and the entire Cloudflare platform. Integrating these models was a significant challenge for me, but in the end, they performed as expected.

Now I see space for integrate AI on any app, Cloudflare is amazing!

**Multiple Models and/or Triple Task Types**

The app use two AI Workers models from Cloudflare to generate text (@cf/meta/llama-2-7b-chat-fp16) and generate images (@cf/stabilityai/stable-diffusion-xl-base-1.0).
