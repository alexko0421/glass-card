import AppKit
import SwiftUI

struct TablerIcon: View {
    let name: String
    var size: CGFloat = 18
    var color: Color = .primary

    var body: some View {
        if let image = Self.image(named: name) {
            Image(nsImage: image)
                .renderingMode(.template)
                .resizable()
                .interpolation(.high)
                .frame(width: size, height: size)
                .foregroundColor(color)
                .accessibilityHidden(true)
        }
    }

    // MARK: - Cache

    private static let cache = NSCache<NSString, NSImage>()

    static func image(named name: String) -> NSImage? {
        if let hit = cache.object(forKey: name as NSString) { return hit }
        guard let data = TablerFilled.svg(named: name), let image = NSImage(data: data) else { return nil }
        image.isTemplate = true
        cache.setObject(image, forKey: name as NSString)
        return image
    }
}
