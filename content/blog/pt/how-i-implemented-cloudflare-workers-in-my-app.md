---
slug: how-i-implemented-cloudflare-workers-in-my-app
title: Como eu implementei Workers da Cloudflare no meu App
description: Nesse post eu vou mostrar como implementei Cloudflare Workers no meu app
publishedAt: 2024/04/14
---

## O que eu desenvolvi
Nottia é um aplicativo simples em Nuxt 3 onde você pode gerar notas, não precisa mais esquecer suas ideias, basta criar uma nota! xD

Neste aplicativo, você também tem a opção de gerar notas enviando prompts para uma IA e recebendo uma resposta com base nesse prompt.

**Gerando uma nota baseado no prompt do user:**
![Note generation](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/494s8ppfpcaq8gtcy64c.gif)

**Gerando uma imagem baseado no prompt do user:**
![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ithtq45kp8tm5ajdbblp.gif)

## Demo

Visualize a demo em um dos links abaixo:

No Cloudflare Pages:
https://nottia.pages.dev/

Na Vercel:
https://nottia.vercel.app/

## Código fonte

O código fonte desse código foi dividido em dois repositórios: um para o frontend e outro para o Worker da Cloudflare.

**Nottia:**

https://github.com/cn-2k/nottia

**Nottia Worker:**

https://github.com/cn-2k/nottia-worker

## Jornada

Inicialmente, este aplicativo era focado em registrar notas manualmente. Com esse desafio, vi a oportunidade de me aprofundar mais em IA, Workers Serverless e em toda a plataforma Cloudflare. Integrar esses modelos foi um desafio significativo para mim, mas, no final, eles funcionaram conforme o esperado.

Agora vejo espaço para integrar IA em qualquer aplicativo. Cloudflare é incrível!

**Múltiplos Models**

O app usa 2 modelos de IA da Cloudflare, 1 para gerar texto (@cf/meta/llama-2-7b-chat-fp16) e outro para gerar imagens (@cf/stabilityai/stable-diffusion-xl-base-1.0).
