import SwiftUI

/// A frosted card with custom content and a repeatable backdrop.
/// The backdrop is redrawn and blurred; live siblings are not sampled.
public struct GlassCard<Content: View, Backdrop: View>: View {
    private let swatch: GlassSwatch
    private let cornerRadius: CGFloat
    private let blurRadius: CGFloat
    private let backdrop: () -> Backdrop
    private let content: () -> Content

    public init(
        swatch: GlassSwatch = .blue,
        cornerRadius: CGFloat = 20,
        blurRadius: CGFloat = 7,
        @ViewBuilder backdrop: @escaping () -> Backdrop,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.swatch = swatch
        self.cornerRadius = max(0, cornerRadius)
        self.blurRadius = max(0, blurRadius)
        self.backdrop = backdrop
        self.content = content
    }

    public var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        content()
            .foregroundStyle(swatch.ink)
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background {
                GlassCardMaterial(swatch: swatch, blurRadius: blurRadius,
                                  backdrop: backdrop, mask: { shape })
            }
            .overlay { shape.strokeBorder(.white.opacity(0.6), lineWidth: 2).allowsHitTesting(false) }
            .clipShape(shape)
            .contentShape(shape)
    }
}

extension GlassCard where Backdrop == GlassPaper {
    /// Uses the bundled grid-paper backdrop. Supply `backdrop:` for another surface.
    public init(
        swatch: GlassSwatch = .blue,
        cornerRadius: CGFloat = 20,
        blurRadius: CGFloat = 7,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(swatch: swatch, cornerRadius: cornerRadius, blurRadius: blurRadius,
                  backdrop: { GlassPaper() }, content: content)
    }
}
