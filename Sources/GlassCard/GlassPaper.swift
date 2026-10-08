import SwiftUI

/// A repeatable backdrop: the pile redraws it behind each frosted card.
public struct GlassPaper: View {
    public init() {}

    public var body: some View {
        Canvas { context, size in
            context.fill(Path(CGRect(origin: .zero, size: size)),
                         with: .color(Color(red: 0.984, green: 0.984, blue: 0.984)))
            let line = Color(red: 0.93, green: 0.93, blue: 0.93)
            for x in stride(from: CGFloat(0), through: size.width, by: 180) {
                context.fill(Path(CGRect(x: x, y: 0, width: 1, height: size.height)), with: .color(line))
            }
            for y in stride(from: CGFloat(0), through: size.height, by: 180) {
                context.fill(Path(CGRect(x: 0, y: y, width: size.width, height: 1)), with: .color(line))
            }
        }
    }
}
