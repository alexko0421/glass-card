import SwiftUI
import GlassCard

/// Frosted demo cards in the selected layout’s drawing order.
/// Content is a noninteractive card label; handle selection in `onSelect`.
struct GlassCardPile<Item: Identifiable, Content: View, Backdrop: View>: View {
    private let items: [Item]
    private let layout: GlassPileLayout
    private let expansion: Binding<Bool>?
    private let trigger: GlassExpansionTrigger
    private let size: CGSize
    private let swatch: (Item) -> GlassSwatch
    private let onSelect: (Item) -> Void
    private let content: (Item) -> Content
    private let backdrop: () -> Backdrop

    @State private var internalExpanded = false
    @State private var hovered: Item.ID?
    @GestureState private var translation: CGSize = .zero
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(
        _ items: [Item],
        layout: GlassPileLayout = .layered,
        isExpanded: Binding<Bool>? = nil,
        expansionTrigger: GlassExpansionTrigger = .click,
        cardSize: CGSize = CGSize(width: 240, height: 120),
        swatch: @escaping (Item) -> GlassSwatch,
        onSelect: @escaping (Item) -> Void = { _ in },
        @ViewBuilder backdrop: @escaping () -> Backdrop,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.layout = layout
        self.expansion = isExpanded
        self.trigger = expansionTrigger
        self.size = cardSize
        self.swatch = swatch
        self.onSelect = onSelect
        self.backdrop = backdrop
        self.content = content
    }

    private var expanded: Bool { expansion?.wrappedValue ?? internalExpanded }
    private var drawingOrder: [Int] { layout.drawingOrder(count: items.count) }
    private var shape: RoundedRectangle { RoundedRectangle(cornerRadius: 20, style: .continuous) }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backdrop()
                    .accessibilityHidden(true)
                    .contentShape(Rectangle())
                    .onTapGesture { setExpanded(false) }
                ForEach(Array(drawingOrder.enumerated()), id: \.element) { depth, index in
                    layer(items[index], index: index,
                          below: Array(drawingOrder.prefix(depth)), canvas: geometry.size)
                        .zIndex(Double(depth))
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .contentShape(Rectangle())
            .onHover { inside in
                if trigger == .hover { setExpanded(inside) }
            }
            .onExitCommand { setExpanded(false) }
        }
        .frame(minWidth: 920, minHeight: 660)
    }

    private func setExpanded(_ value: Bool) {
        if let expansion { expansion.wrappedValue = value }
        else { internalExpanded = value }
    }

    private func shift(for index: Int) -> Animation? {
        guard !reduceMotion else { return nil }
        let sequence = expanded ? index : items.count - index - 1
        return .spring(response: 0.48, dampingFraction: 0.86)
            .delay(Double(min(sequence, 8)) * 0.025)
    }

    private func placed<V: View>(_ index: Int, canvas: CGSize, @ViewBuilder _ view: () -> V) -> some View {
        let pose = layout.pose(at: index, count: items.count, expanded: expanded)
        let follow = reduceMotion ? 1.0 : 1.0 - Double(items.count - index - 1) * 0.025
        return view()
            .frame(width: size.width, height: size.height)
            .rotationEffect(.degrees(pose.rotation))
            .offset(x: pose.x + translation.width * max(0.6, follow),
                    y: pose.y + translation.height * max(0.6, follow))
            .frame(width: canvas.width, height: canvas.height)
            .animation(shift(for: index), value: expanded)
    }

    private func layer(_ item: Item, index: Int, below: [Int], canvas: CGSize) -> some View {
        let tint = swatch(item)
        let isHovered = hovered == item.id
        return ZStack {
            GlassCardMaterial(swatch: tint, backdrop: {
                ZStack {
                    backdrop()
                    ForEach(below, id: \.self) { belowIndex in
                        placed(belowIndex, canvas: canvas) {
                            ZStack {
                                shape.fill(.white)
                                shape.fill(swatch(items[belowIndex]).tint.opacity(swatch(items[belowIndex]).opacity))
                                content(items[belowIndex]).foregroundStyle(swatch(items[belowIndex]).ink).padding(16)
                            }
                        }
                    }
                }
                .frame(width: canvas.width, height: canvas.height)
            }, mask: { placed(index, canvas: canvas) { shape } })
            .shadow(color: .black.opacity(isHovered ? 0.06 : 0.035), radius: 12, y: 8)
            .shadow(color: .black.opacity(0.045), radius: 3, y: 2)
            .allowsHitTesting(false)
            .accessibilityHidden(true)

            placed(index, canvas: canvas) {
                Button {
                    if expanded { onSelect(item) }
                    else { setExpanded(true) }
                } label: {
                    content(item)
                        .foregroundStyle(tint.ink)
                        .padding(16)
                        .frame(width: size.width, height: size.height, alignment: .topLeading)
                        .overlay {
                            shape.strokeBorder(.white.opacity(isHovered ? 0.9 : 0.65), lineWidth: 1.5)
                        }
                        .contentShape(shape)
                }
                .buttonStyle(.plain)
                .accessibilityElement(children: .combine)
                .accessibilityHint(expanded ? "Select card" : "Expand cards")
                .accessibilityHidden(!expanded && index != drawingOrder.last)
                .onHover { inside in
                    if inside { hovered = item.id }
                    else if hovered == item.id { hovered = nil }
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 12)
                        .updating($translation) { value, state, _ in state = value.translation }
                        .onEnded { value in
                            if value.translation.height > 40 { setExpanded(true) }
                            if value.translation.height < -40 { setExpanded(false) }
                        }
                )
            }
        }
    }
}

extension GlassCardPile where Backdrop == GlassPaper {
    init(
        _ items: [Item],
        layout: GlassPileLayout = .layered,
        isExpanded: Binding<Bool>? = nil,
        expansionTrigger: GlassExpansionTrigger = .click,
        cardSize: CGSize = CGSize(width: 240, height: 120),
        swatch: @escaping (Item) -> GlassSwatch,
        onSelect: @escaping (Item) -> Void = { _ in },
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.init(items, layout: layout, isExpanded: isExpanded,
                  expansionTrigger: expansionTrigger, cardSize: cardSize,
                  swatch: swatch, onSelect: onSelect, backdrop: { GlassPaper() }, content: content)
    }
}
