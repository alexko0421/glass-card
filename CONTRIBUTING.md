# Contributing

[简体中文](CONTRIBUTING.zh-CN.md)

Glass Card focuses on a small, reusable card material for macOS. Changes to blur, masking, tint, rendering, and the clarity of the examples are welcome.

## Structure

- `Sources/GlassCard`: the four public material types.
- `Sources/GlassCardDemo`: layouts, labels, icons, and demo interactions.
- `Tests/GlassCardTests`: pixel-based material checks.
- `docs/images`: rendered screenshots used by both READMEs.

Keep presentation choices in the demo. Public material views should accept caller content and repeatable backdrops.

## Work on a change

Use macOS 14+ and Swift 5.9+ with Xcode command-line tools, then run:

```sh
swift build
swift test
swift run GlassCardDemo
```

For a visual change, inspect the affected state in the running demo. Check both layouts if you change stacking or backdrop alignment. If animation changes, also inspect it with the macOS Reduce Motion setting enabled.

Export fresh previews when the documented appearance changes:

```sh
swift run GlassCardDemo --render-previews ./previews
```

Copy `material.png`, `layered.png`, and `ring.png` into `docs/images`. `cover.png` is the selected full-window screenshot and is updated separately. Keep the English and Chinese READMEs consistent when changing usage or limitations.

## Report an issue or submit a change

Include your macOS version, Swift version (`swift --version`), reproduction steps, and expected versus observed behavior. A screenshot is useful for visual issues.

For a pull request, explain the problem, the resulting behavior, and the checks you ran. Add tests for material behavior that can be verified meaningfully; a small layout adjustment can be checked with rendered previews and the native demo.

Preserve the MIT license, sam's inspiration credit, and the Tabler notice. Include the appropriate license and attribution with any new third-party asset.
