# 贡献说明

[English](CONTRIBUTING.md)

Glass Card 专注于小型、可复用的 macOS 卡片材质。欢迎改进模糊、裁切、颜色、渲染效果，以及示例的易用性。

## 目录结构

- `Sources/GlassCard`：四个公开材质类型。
- `Sources/GlassCardDemo`：布局、卡片内容、图标和演示交互。
- `Tests/GlassCardTests`：基于渲染像素的材质检查。
- `docs/images`：中英文 README 共用的预览图。

布局与展示选择留在演示中，公开材质组件接受使用者自己的内容与可重复绘制的背景。

## 修改与验证

使用 macOS 14+、Swift 5.9+ 和 Xcode 命令行工具，执行：

```sh
swift build
swift test
swift run GlassCardDemo
```

视觉改动应在运行中的演示里查看实际效果。修改叠放或背景对齐时，检查两种布局；修改动画时，也检查 macOS 开启“减少动态效果”后的表现。

文档中的外观变化时，重新导出预览：

```sh
swift run GlassCardDemo --render-previews ./previews
```

把 `material.png`、`layered.png` 和 `ring.png` 复制到 `docs/images`。`cover.png` 是选定的完整窗口截图，单独更新。用法或限制变化时，同步更新中英文文档。

## 提交问题或改动

问题报告请包含 macOS 版本、Swift 版本（`swift --version`）、复现步骤、预期行为和实际行为。视觉问题可以附上截图。

Pull request 说明应讲清问题、修改后的行为和执行过的检查。可明确验证的材质行为适合添加测试；小幅布局改动可以通过渲染预览与原生演示检查。

保留 MIT 许可、sam 的灵感署名和 Tabler 许可声明。引入新的第三方资源时附上对应的许可与署名。
