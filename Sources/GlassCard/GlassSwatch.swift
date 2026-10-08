import SwiftUI

/// The card tint and its recommended foreground color.
public struct GlassSwatch {
    public var tint: Color
    public var ink: Color
    public var opacity: Double

    public init(tint: Color, ink: Color, opacity: Double = 0.58) {
        self.tint = tint
        self.ink = ink
        self.opacity = min(1, max(0, opacity))
    }

    public static let blue = hex(0x3769F5, 0x18428E)
    public static let rose = hex(0xEE556D, 0x881D2D)
    public static let violet = hex(0x9B38EC, 0x4A1478)
    public static let mint = hex(0x68BD81, 0x1F5E33)
    public static let lemon = hex(0xF2F766, 0x5A5E12)
    public static let orange = hex(0xF5963C, 0x7A3E0A)
    public static let teal = hex(0x2EC2C4, 0x0B5557)
    public static let graphite = hex(0x3A3F4A, 0x15181E)
    public static let pearl = hex(0xFFFFFF, 0x484848, opacity: 0.45)

    public static let presets: [GlassSwatch] = [
        .blue, .rose, .violet, .mint, .lemon, .orange, .teal, .graphite, .pearl
    ]

    private static func hex(_ tint: UInt32, _ ink: UInt32, opacity: Double = 0.58) -> Self {
        Self(tint: color(tint), ink: color(ink), opacity: opacity)
    }

    private static func color(_ hex: UInt32) -> Color {
        Color(.sRGB, red: Double((hex >> 16) & 255) / 255,
              green: Double((hex >> 8) & 255) / 255, blue: Double(hex & 255) / 255)
    }
}
