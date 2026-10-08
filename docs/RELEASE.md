# Initial release materials

[简体中文](RELEASE.zh-CN.md)

Materials for **v0.1.0**. [Repository](https://github.com/alexko0421/glass-card) · [Release](https://github.com/alexko0421/glass-card/releases/tag/v0.1.0)

## Repository details

Repository name: `glass-card`

Description:

> A small macOS SwiftUI package for tinted, frosted cards with overlapping color and adjustable blur.

Topics: `swift`, `swiftui`, `macos`, `glassmorphism`, `ui-components`

Release title: **v0.1.0 — Frosted color, softly layered.**

Attach the prepared `glass-card-source.zip` and `glass-card-demo-macos.zip`. The app bundle is ad-hoc signed; it has not been notarized. The source can be built locally with `swift run GlassCardDemo`.

The release contains the source and macOS demo archives. The changelog records version 0.1.0 and its release date.

## Release body

Glass Card is a small SwiftUI package for colored, frosted card surfaces on macOS.

This first release includes four public material types, nine color presets, configurable blur, and a demo showing overlapping cards in Layered and Ring layouts. Card content stays sharp while the supplied backdrop blurs and mixes underneath.

Requires macOS 14+ and Swift 5.9+. No external package dependencies.

The material redraws an explicitly supplied backdrop; it does not automatically capture live sibling views. Overlapping layers in the demo are an approximation. Large stacks have not been benchmarked.

Visual inspiration: sam ([@artntek](https://x.com/artntek)), [Event Stack Shifting](https://x.com/artntek/status/2100247096993485129). Demo icons: Tabler Icons, with their MIT notice included. Code: MIT.

## Introduction post — English

I’m sharing Glass Card: a small macOS SwiftUI package for colored, frosted cards.

The focus is the material: soft blur, translucent color, and the way overlapping cards mix. It comes with nine colors and a demo with Layered and Ring layouts.

Inspired by sam’s (@artntek) Event Stack Shifting. Demo icons are from Tabler. MIT licensed, with no external package dependencies.

Repository: https://github.com/alexko0421/glass-card Use the rose screenshot `docs/images/cover.png` as the lead image, with `material.png` for the close-up and `ring.png` for the alternate layout.

## Introduction post — 简体中文

分享一个小组件：Glass Card，用 SwiftUI 实现 macOS 上的彩色磨砂卡片。

主要想分享的是材质：柔和的模糊、半透明的颜色，以及卡片重叠时透出的混色。附带九种颜色和 Layered、Ring 两种布局演示。

视觉灵感来自 sam（@artntek）的 Event Stack Shifting，演示图标来自 Tabler。MIT 开源，没有外部包依赖。

仓库：https://github.com/alexko0421/glass-card

首图用玫瑰粉截图 `docs/images/cover.png`，材质特写用 `material.png`，另一种布局用 `ring.png`。
