# 首版开源资料

[English](RELEASE.md)

**v0.1.0** 开源资料。[仓库](https://github.com/alexko0421/glass-card) · [Release](https://github.com/alexko0421/glass-card/releases/tag/v0.1.0)

## 仓库资料

仓库名称：`glass-card`

英文简介：

> A small macOS SwiftUI package for tinted, frosted cards with overlapping color and adjustable blur.

中文简介：

> 一个小型 macOS SwiftUI 彩色磨砂卡片组件，支持重叠混色与可调模糊。

建议 Topics：`swift`、`swiftui`、`macos`、`glassmorphism`、`ui-components`

首版标题：**v0.1.0 — Frosted color, softly layered.**

发布附件使用已准备的 `glass-card-source.zip` 和 `glass-card-demo-macos.zip`。应用包使用临时签名（ad-hoc），尚未完成 Apple 公证；也可以通过 `swift run GlassCardDemo` 从源码运行。

Release 包含源码和 macOS 演示附件，更新记录已列出 0.1.0 版本与日期。

## Release 说明 — 中文

Glass Card 是一个用于 macOS 彩色磨砂卡片的小型 SwiftUI 组件。

首版包含四个公开材质类型、九种预设颜色、可调模糊，以及 Layered 和 Ring 两种重叠布局演示。卡片前景内容保持清晰，传入的背景在底下模糊并混色。

要求 macOS 14+、Swift 5.9+，没有外部包依赖。

材质会重新绘制显式传入的背景，不会自动捕获卡片后面的其他视图。演示中的多层合成是近似效果，大量卡片尚未进行性能基准测试。

视觉灵感来自 sam（[@artntek](https://x.com/artntek)）的 [Event Stack Shifting](https://x.com/artntek/status/2100247096993485129)。演示图标来自 Tabler Icons，已保留其 MIT 许可声明。代码使用 MIT 许可。

对应英文 Release 说明见 [RELEASE.md](RELEASE.md#release-body)。

## 介绍文案 — 中文

分享一个小组件：Glass Card，用 SwiftUI 实现 macOS 上的彩色磨砂卡片。

主要想分享的是材质：柔和的模糊、半透明的颜色，以及卡片重叠时透出的混色。附带九种颜色和 Layered、Ring 两种布局演示。

视觉灵感来自 sam（@artntek）的 Event Stack Shifting，演示图标来自 Tabler。MIT 开源，没有外部包依赖。

## Introduction post — English

I’m sharing Glass Card: a small macOS SwiftUI package for colored, frosted cards.

The focus is the material: soft blur, translucent color, and the way overlapping cards mix. It comes with nine colors and a demo with Layered and Ring layouts.

Inspired by sam’s (@artntek) Event Stack Shifting. Demo icons are from Tabler. MIT licensed, with no external package dependencies.

仓库：https://github.com/alexko0421/glass-card

首图使用玫瑰粉截图 `docs/images/cover.png`，材质特写使用 `material.png`，另一种布局使用 `ring.png`。
