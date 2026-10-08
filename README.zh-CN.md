# Glass Card

柔和的颜色，层叠的磨砂质感。

一个用于 macOS 的 SwiftUI 卡片材质组件。提供背景和自己的内容，就可以得到带模糊、半透明色彩与柔和白边的卡片。

[English](README.md)

![玫瑰粉磨砂卡片透出底下的蓝色与粉色](docs/images/cover.png)

## 包含什么

- 可放入自定义 SwiftUI 内容的卡片材质。
- 九种预设颜色，以及自定义颜色、文字颜色和透明度。
- 可调节的模糊强度与圆角。
- macOS 演示：单卡材质、三排错位叠放（Layered）和环形叠放（Ring）。

公开组件是卡片材质；布局、展开、选择、拖动和实心图标放在演示中。

**模糊需要显式提供背景。** 组件重新绘制你传入的背景，不会自动捕获卡片后面的其他视图。

## 运行要求

macOS 14 或更新版本、Swift 5.9 或更新版本，以及 Xcode 命令行工具。没有外部包依赖。

## 运行演示

可以在 [v0.1.0 Release](https://github.com/alexko0421/glass-card/releases/tag/v0.1.0) 下载 macOS 演示或源码包。想从源码运行，在源码目录执行：

```sh
swift run GlassCardDemo
```

Material 页面可以切换颜色、调节模糊；Stack 页面可以选择 Layered 或 Ring，点击 Expand 展开。点击卡片进行选择，点击空白处或按 Esc 收起。向下拖动展开，向上拖动收起，也可以开启 Hover。

| Layered | Ring |
| --- | --- |
| ![三排错位叠放](docs/images/layered.png) | ![环形叠放](docs/images/ring.png) |

## 使用卡片

在 Xcode 中把 `https://github.com/alexko0421/glass-card` 添加为包依赖，版本从 **0.1.0** 开始，选择 **GlassCard** library product。也可以把下载的源码目录添加为本地 Swift Package。

```swift
import SwiftUI
import GlassCard

struct Example: View {
    var body: some View {
        GlassCard(swatch: .rose) {
            VStack(alignment: .leading, spacing: 6) {
                Text("A little clarity").font(.caption)
                Spacer()
                Text("Room for a new idea").font(.headline)
            }
        }
        .frame(width: 300, height: 160)
    }
}
```

默认背景是组件自带的网格纸。想展示混色时，使用 `backdrop:` 提供底下的场景：

```swift
GlassCard(swatch: .rose, blurRadius: 7, backdrop: {
    HStack(spacing: 0) {
        Color.blue
        Color.pink
    }
}) {
    Text("Your own content").font(.headline)
}
.frame(width: 300, height: 160)
```

卡片内置 16 点内容边距、圆角裁切与白边，可以放入控件；阴影和交互通过常规 SwiftUI modifier 添加。

## 材质与限制

组件把传入的背景合成后提高饱和度、施加模糊、叠加半透明颜色，再按形状裁切。前景文字和图标保持清晰。

自定义重叠场景可以直接使用 `GlassCardMaterial`；背景与 `mask:` 必须位于同一坐标空间。背景会被再次绘制，因此应保持可重复、无交互、无副作用。单独设置父视图的 `.background` 不会为组件提供模糊来源。

演示把底层卡片重新绘制成扁平图层，多层玻璃效果属于近似合成。大量卡片尚未进行性能基准测试。前景对比度取决于实际背景。

公开 API 包含 `GlassCard`、`GlassCardMaterial`、`GlassSwatch` 和 `GlassPaper`。预设颜色有 blue、rose、violet、mint、lemon、orange、teal、graphite 和 pearl。普通预设的颜色不透明度为 58%，pearl 为 45%。

完整 API 用法和底层材质示例见 [英文 README](README.md#how-the-material-works)。

## 开发

```sh
swift build
swift test
swift run GlassCardDemo --render-previews ./previews
```

四个测试覆盖圆角、模糊、色彩与透明度：三个检查 SwiftUI 渲染像素，一个检查颜色配置中的透明度值。预览命令导出 material、layered、ring、collapsed、single、empty 六张 PNG。贡献说明见 [中文贡献说明](CONTRIBUTING.zh-CN.md)。

更新记录见 [CHANGELOG.zh-CN.md](CHANGELOG.zh-CN.md)。

## 灵感与许可

视觉灵感来自 sam（[@artntek](https://x.com/artntek)）的 [Event Stack Shifting](https://x.com/artntek/status/2100247096993485129)。本项目是独立的 SwiftUI 实现，未包含原作者的视频或原始作品文件。

代码使用 [MIT 许可](LICENSE)，版权归 2026 Chunlong Ko。演示包含六个 Tabler Icons 实心 SVG（3.46.0）；其 MIT 许可保留在 [THIRD_PARTY_NOTICES.txt](THIRD_PARTY_NOTICES.txt)。
