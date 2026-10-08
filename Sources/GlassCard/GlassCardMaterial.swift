import SwiftUI

/// A simulated frosted backdrop, masked in the backdrop's coordinate space.
/// Supply repeatable, noninteractive views in both closures.
public struct GlassCardMaterial<Backdrop: View, Mask: View>: View {
    private let swatch: GlassSwatch
    private let blurRadius: CGFloat
    private let backdrop: () -> Backdrop
    private let mask: () -> Mask

    public init(
        swatch: GlassSwatch,
        blurRadius: CGFloat = 7,
        @ViewBuilder backdrop: @escaping () -> Backdrop,
        @ViewBuilder mask: @escaping () -> Mask
    ) {
        self.swatch = swatch
        self.blurRadius = max(0, blurRadius)
        self.backdrop = backdrop
        self.mask = mask
    }

    public var body: some View {
        ZStack {
            backdrop()
                .compositingGroup()
                .saturation(1.3)
                .blur(radius: blurRadius, opaque: true)
            swatch.tint.opacity(min(1, max(0, swatch.opacity)))
        }
        .mask { mask() }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}
