import SwiftUI

struct CardDots: View {
    let color: Color
    var body: some View {
        HStack(spacing: 2.5) {
            ForEach(0..<3, id: \.self) { _ in
                Circle().fill(color.opacity(0.35)).frame(width: 3, height: 3)
            }
        }
        .padding(.top, 4)
        .accessibilityHidden(true)
    }
}
