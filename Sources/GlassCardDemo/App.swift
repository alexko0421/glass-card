import AppKit
import SwiftUI
import GlassCard

struct DemoCard: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let symbol: String
    var swatch: GlassSwatch { GlassSwatch.presets[id] }

    static let colorNames = ["Blue", "Rose", "Violet", "Mint", "Lemon", "Orange", "Teal", "Graphite", "Pearl"]

    static let samples: [DemoCard] = [
        .init(id: 0, title: "New directions", subtitle: "Today, 3:00 PM", symbol: "navigation"),
        .init(id: 1, title: "Make something", subtitle: "Tomorrow", symbol: "flag"),
        .init(id: 2, title: "Keep an idea", subtitle: "Saved for later", symbol: "message-circle"),
        .init(id: 3, title: "A little fresh air", subtitle: "This afternoon", symbol: "calendar"),
        .init(id: 4, title: "Let the light in", subtitle: "Every morning", symbol: "sun"),
        .init(id: 5, title: "Try something new", subtitle: "This weekend", symbol: "flag"),
        .init(id: 6, title: "Go somewhere", subtitle: "Sunday, 10:00 AM", symbol: "navigation"),
        .init(id: 7, title: "Make some room", subtitle: "Whenever you need", symbol: "file-text"),
        .init(id: 8, title: "A blank page", subtitle: "A fresh start", symbol: "file-text")
    ]
}

struct CardLabel: View {
    let card: DemoCard
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                TablerIcon(name: card.symbol, size: 22, color: card.swatch.ink)
                Spacer()
                CardDots(color: card.swatch.ink)
            }
            .accessibilityHidden(true)
            Spacer()
            Text(card.subtitle).font(.system(size: 12, weight: .medium)).opacity(0.75)
            Text(card.title).font(.system(size: 15, weight: .semibold)).lineLimit(1).padding(.top, 3)
        }
    }
}

struct DemoView: View {
    @State private var showsStack = false
    @State private var colorIndex = 1
    @State private var blur = 7.0
    @State private var open = false
    @State private var useRing = false
    @State private var hover = false
    @State private var selected: String?

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("Glass Card").font(.system(size: 19, weight: .semibold))
                    Text("Frosted color, softly layered.").font(.system(size: 12)).foregroundStyle(.secondary)
                }
                Spacer()
                Picker("Demo", selection: $showsStack) {
                    Text("Material").tag(false)
                    Text("Stack").tag(true)
                }
                .pickerStyle(.segmented).labelsHidden().frame(width: 160)
                if showsStack {
                Picker("Layout", selection: $useRing) {
                    Text("Layered").tag(false)
                    Text("Ring").tag(true)
                }
                .pickerStyle(.segmented).labelsHidden().frame(width: 160)
                Toggle("Hover", isOn: $hover).toggleStyle(.checkbox)
                Button(open ? "Collapse" : "Expand") { open.toggle() }.keyboardShortcut("e", modifiers: .command)
                }
            }
            .padding(.horizontal, 28).padding(.vertical, 20)
            Divider()
            if showsStack {
                GlassCardPile(DemoCard.samples, layout: useRing ? .ring : .layered,
                          isExpanded: $open, expansionTrigger: hover ? .hover : .click,
                          swatch: { $0.swatch }, onSelect: { selected = $0.title }) {
                CardLabel(card: $0)
                }
            } else {
                MaterialShowcase(swatch: GlassSwatch.presets[colorIndex], blur: blur, icon: DemoCard.samples[colorIndex].symbol)
                    .overlay(alignment: .bottom) {
                        HStack(spacing: 12) {
                            ForEach(0..<GlassSwatch.presets.count, id: \.self) { index in
                                Button { colorIndex = index } label: {
                                    Circle().fill(GlassSwatch.presets[index].tint)
                                        .frame(width: 23, height: 23)
                                        .overlay { Circle().stroke(colorIndex == index ? .black.opacity(0.6) : .black.opacity(0.1), lineWidth: 2) }
                                        .padding(4)
                                }
                                .buttonStyle(.plain).help(DemoCard.colorNames[index])
                                .accessibilityLabel(DemoCard.colorNames[index])
                            }
                            Divider().frame(height: 22)
                            Text("Blur").font(.system(size: 12)).foregroundStyle(.secondary)
                            Slider(value: $blur, in: 0...16).frame(width: 110)
                        }
                        .padding(.bottom, 35)
                    }
            }
            Divider()
            HStack {
                Text(showsStack ? (selected.map { "Selected: \($0)" } ?? "Click to expand · Drag down to open · Click empty space or press Esc to close") : "Pick a color · Adjust the blur · See the layers through the card")
                    .font(.system(size: 11)).foregroundStyle(.secondary)
                Spacer()
                Text("macOS · SwiftUI · MIT").font(.system(size: 10, design: .monospaced)).foregroundStyle(.secondary)
            }
            .padding(.horizontal, 28).padding(.vertical, 14)
        }
        .background(Color.white)
        .environment(\.colorScheme, .light)
    }
}

@main
struct GlassCardDemoApp: App {
    init() {
        let arguments = CommandLine.arguments
        if let index = arguments.firstIndex(of: "--render-previews"), index + 1 < arguments.count {
            Self.renderPreviews(to: arguments[index + 1])
            exit(0)
        }
    }

    var body: some Scene {
        WindowGroup("Glass Card") { DemoView() }
            .defaultSize(width: 1000, height: 800)
    }

    @MainActor
    static func renderPreviews(to directory: String) {
        do {
            try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true)
            let material = ImageRenderer(content: MaterialShowcase(swatch: .rose, blur: 7, icon: "flag")
                .frame(width: 1000, height: 720).environment(\.colorScheme, .light))
            material.scale = 2
            guard let materialImage = material.cgImage,
                  let materialPNG = NSBitmapImageRep(cgImage: materialImage).representation(using: .png, properties: [:])
            else { throw CocoaError(.fileWriteUnknown) }
            try materialPNG.write(to: URL(fileURLWithPath: directory).appendingPathComponent("material.png"))
            print("Rendered material")
            for (name, count, expanded, layout) in [
                ("layered", 9, true, GlassPileLayout.layered),
                ("collapsed", 9, false, .layered),
                ("ring", 9, true, .ring),
                ("single", 1, true, .layered),
                ("empty", 0, true, .layered)
            ] {
                let renderer = ImageRenderer(content:
                    GlassCardPile(Array(DemoCard.samples.prefix(count)), layout: layout,
                                  isExpanded: .constant(expanded), swatch: { $0.swatch }) {
                        CardLabel(card: $0)
                    }
                    .frame(width: 1000, height: 720)
                    .environment(\.colorScheme, .light)
                )
                renderer.scale = 2
                guard let cgImage = renderer.cgImage,
                      let png = NSBitmapImageRep(cgImage: cgImage).representation(using: .png, properties: [:])
                else { throw CocoaError(.fileWriteUnknown) }
                try png.write(to: URL(fileURLWithPath: directory).appendingPathComponent("\(name).png"))
                print("Rendered \(name): \(cgImage.width)×\(cgImage.height)")
            }
        } catch {
            fputs("Preview rendering failed: \(error)\n", stderr)
            exit(1)
        }
    }
}
