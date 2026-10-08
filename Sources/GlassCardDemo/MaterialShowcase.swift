import SwiftUI
import GlassCard

/// Only the material is shared with the library; composition stays in the demo.
struct MaterialShowcase: View {
    let swatch: GlassSwatch
    let blur: CGFloat
    var icon: String = "navigation"

    private var scene: some View {
        ZStack {
            GlassPaper()
            RoundedRectangle(cornerRadius: 20)
                .fill(GlassSwatch.blue.tint.opacity(0.58))
                .frame(width: 280, height: 152)
                .rotationEffect(.degrees(-13)).offset(x: -98, y: -18)
            RoundedRectangle(cornerRadius: 20)
                .fill(GlassSwatch.rose.tint.opacity(0.58))
                .frame(width: 280, height: 152)
                .rotationEffect(.degrees(12)).offset(x: 106, y: 12)
            Text("A thought underneath").font(.system(size: 16, weight: .medium))
                .foregroundStyle(GlassSwatch.blue.ink).offset(x: -85, y: -54)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                scene
                GlassCardMaterial(swatch: swatch, blurRadius: blur,
                                  backdrop: { scene }, mask: {
                    RoundedRectangle(cornerRadius: 20).frame(width: 300, height: 160)
                })
                .shadow(color: .black.opacity(0.10), radius: 20, y: 10)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        TablerIcon(name: icon, size: 24, color: swatch.ink)
                        Spacer()
                        CardDots(color: swatch.ink)
                    }
                    Spacer()
                    Text("A little clarity").font(.system(size: 13)).opacity(0.7)
                    Text("Room for a new idea").font(.system(size: 19, weight: .semibold)).padding(.top, 3)
                }
                .foregroundStyle(swatch.ink)
                .padding(20).frame(width: 300, height: 160)
                .overlay { RoundedRectangle(cornerRadius: 20).strokeBorder(.white.opacity(0.6), lineWidth: 2) }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .frame(minWidth: 920, minHeight: 660)
    }
}
