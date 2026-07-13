import SwiftUI

final class OverlayManager {

    private let window = OverlayWindow()

    func show() {
        window.show()
    }

    func listening() {
        window.setState(.listening)
    }

    func processing() {
        window.setState(.processing)
    }

    func hide() {
        window.hide()
    }
    
    func updateLevel(_ level: CGFloat) {
        window.updateLevel(level)
    }
}
