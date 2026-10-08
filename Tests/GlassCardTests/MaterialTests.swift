import AppKit
import XCTest
import SwiftUI
@testable import GlassCard

final class MaterialTests: XCTestCase {
    @MainActor
    private func render<V: View>(_ view: V) throws -> NSBitmapImageRep {
        let renderer = ImageRenderer(content: view.frame(width: 240, height: 120))
        renderer.scale = 1
        return NSBitmapImageRep(cgImage: try XCTUnwrap(renderer.cgImage))
    }

    @MainActor
    func testDefaultCardAndCustomContentRender() throws {
        let image = try render(GlassCard(swatch: .blue) { Text("Hello") })
        XCTAssertEqual(image.pixelsWide, 240)
        XCTAssertEqual(image.pixelsHigh, 120)
        let corner = try XCTUnwrap(image.colorAt(x: 0, y: 0))
        XCTAssertLessThan(corner.alphaComponent, 0.1)
        XCTAssertGreaterThan(try XCTUnwrap(image.colorAt(x: 120, y: 60)).alphaComponent, 0.9)
    }

    @MainActor
    func testMaterialBlursBackdropBeforeApplyingTint() throws {
        func material(blur: CGFloat) -> some View {
            GlassCardMaterial(swatch: GlassSwatch(tint: .white, ink: .black, opacity: 0),
                              blurRadius: blur, backdrop: {
                HStack(spacing: 0) { Color.black; Color.white }
            }, mask: { Rectangle() })
        }
        let sharp = try render(material(blur: 0))
        let frosted = try render(material(blur: 7))
        let sharpLeft = try XCTUnwrap(sharp.colorAt(x: 116, y: 60)?.usingColorSpace(.deviceRGB)).redComponent
        let blurLeft = try XCTUnwrap(frosted.colorAt(x: 116, y: 60)?.usingColorSpace(.deviceRGB)).redComponent
        let blurRight = try XCTUnwrap(frosted.colorAt(x: 124, y: 60)?.usingColorSpace(.deviceRGB)).redComponent
        XCTAssertLessThan(sharpLeft, 0.05)
        XCTAssertGreaterThan(blurLeft, sharpLeft + 0.1)
        XCTAssertLessThan(blurRight, 0.95)
        XCTAssertLessThan(blurLeft, blurRight)
    }

    @MainActor
    func testTransparentTintPreservesBackdropAndOpaqueTintCoversIt() throws {
        for (opacity, expected) in [(0.0, 0.0), (1.0, 1.0)] {
            let image = try render(GlassCardMaterial(
                swatch: GlassSwatch(tint: .white, ink: .black, opacity: opacity),
                backdrop: { Color.black }, mask: { Rectangle() }
            ))
            let pixel = try XCTUnwrap(image.colorAt(x: 120, y: 60)?.usingColorSpace(.deviceRGB))
            XCTAssertEqual(pixel.redComponent, expected, accuracy: 0.03)
        }
    }

    func testOpacityIsClampedAndPearlRemainsMoreTransparent() {
        XCTAssertEqual(GlassSwatch(tint: .red, ink: .black, opacity: -1).opacity, 0)
        XCTAssertEqual(GlassSwatch(tint: .red, ink: .black, opacity: 2).opacity, 1)
        XCTAssertLessThan(GlassSwatch.pearl.opacity, GlassSwatch.blue.opacity)
    }
}
