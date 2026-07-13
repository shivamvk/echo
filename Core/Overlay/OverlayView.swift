import SwiftUI

enum OverlayState {
    case listening
    case processing
}

struct OverlayView: View {

    @ObservedObject
    var store: OverlayStateStore

    @State
    private var animate = false

    private let baseHeights: [CGFloat] = [8, 12, 18, 24, 18, 12, 8]
    private let multipliers: [CGFloat] = [
        0.35,
        0.65,
        1.1,
        1.6,
        1.1,
        0.65,
        0.35
    ]

    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 17)
                .fill(Color.black.opacity(0.82))

            RoundedRectangle(cornerRadius: 17)
                .stroke(Color.white.opacity(0.05), lineWidth: 0.8)

            HStack(spacing: 5) {

                ForEach(0..<baseHeights.count, id: \.self) { index in

                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(store.state == .processing ? 0.45 : 1))
                        .frame(
                            width: 2.5,
                            height: store.state == .listening
                                ? baseHeights[index] + max(0.05, min(store.audioLevel, 1)) * 18 * multipliers[index]
                                : baseHeights[index]
                        )
                        .animation(
                            .interactiveSpring(
                                response: 0.15,
                                dampingFraction: 0.72
                            ),
                            value: store.audioLevel
                        )
                }

            }

        }
        .frame(width: 118, height: 42)
        .shadow(
            color: .black.opacity(0.22),
            radius: 12,
            y: 4
        )
        .scaleEffect(animate ? 1 : 0.94)
        .opacity(store.state == .processing ? 0.45 : 1)
        .animation(
            .spring(response: 0.30, dampingFraction: 0.78),
            value: animate
        )
        .onAppear {
            animate = true
        }
    }
}
