import Foundation
import Combine
import CoreGraphics

@MainActor
final class OverlayStateStore: ObservableObject {

    @Published var state: OverlayState = .listening
    @Published var audioLevel: CGFloat = 0
}
