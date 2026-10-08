import SwiftUI
import GlassCard

struct GlassCardPose: Equatable {
    var x: CGFloat
    var y: CGFloat
    var rotation: Double

    init(x: CGFloat = 0, y: CGFloat = 0, rotation: Double = 0) {
        self.x = x
        self.y = y
        self.rotation = rotation
    }
}

/// Positions are relative to the center of the pile.
enum GlassPileLayout {
    case layered
    case ring
    case custom((_ index: Int, _ count: Int, _ expanded: Bool) -> GlassCardPose)

    func pose(at index: Int, count: Int, expanded: Bool) -> GlassCardPose {
        guard count > 0 else { return GlassCardPose() }
        if case let .custom(position) = self { return position(index, count, expanded) }
        guard count > 1 else { return GlassCardPose() }
        guard expanded else {
            let n = Double(index % 5) - 2
            return GlassCardPose(x: n * 2, y: n, rotation: n * 2)
        }
        switch self {
        case .layered:
            // Shingled rows leave the lower text area clear while mixing along edges.
            if count == 9 {
                let slots: [GlassCardPose] = [
                    .init(x: -210, y: -107, rotation: -8),
                    .init(x: 0, y: -120, rotation: -2),
                    .init(x: 201, y: 113, rotation: 5),
                    .init(x: -193, y: -8, rotation: -6),
                    .init(x: 16, y: -8, rotation: 1),
                    .init(x: 224, y: 8, rotation: 6),
                    .init(x: -220, y: 103, rotation: -8),
                    .init(x: -10, y: 96, rotation: -1),
                    .init(x: 210, y: -100, rotation: 6)
                ]
                return slots[index]
            }
            let columns = min(3, count)
            let rows = (count + columns - 1) / columns
            return GlassCardPose(
                x: (Double(index % columns) - Double(columns - 1) / 2) * 210,
                y: (Double(index / columns) - Double(rows - 1) / 2) * 105,
                rotation: Double(index % columns - 1) * 4
            )
        case .ring:
            if count == 9 {
                let slots: [(Double, Double)] = [
                    (210, 6), (50, -3), (90, 0), (-30, -10),
                    (170, 4), (10, -6), (130, 3), (-70, -8), (-110, -12)
                ]
                let radians = slots[index].0 * .pi / 180
                let verticalAdjustment = index == 8 ? -30.0 : (index == 7 ? 15.0 : 0.0)
                return GlassCardPose(x: cos(radians) * 235, y: sin(radians) * 185 + verticalAdjustment,
                                     rotation: slots[index].1)
            }
            let angle = Double(index) / Double(count) * .pi * 2 - .pi / 2
            return GlassCardPose(x: cos(angle) * 235, y: sin(angle) * 185,
                                 rotation: cos(angle) * 8)
        case .custom:
            return GlassCardPose()
        }
    }

    func drawingOrder(count: Int) -> [Int] {
        if case .layered = self, count == 9 {
            return [6, 7, 2, 3, 4, 5, 0, 1, 8]
        }
        if case .ring = self, count == 9 {
            return [2, 1, 6, 5, 4, 3, 0, 7, 8]
        }
        return Array(0..<count)
    }
}

enum GlassExpansionTrigger {
    /// Click the top card, or drag down; click empty space, or drag up to close.
    case click
    /// Optional presentation mode for a hover-driven demo.
    case hover
}
