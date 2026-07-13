import AppKit
import SwiftUI

final class OverlayWindow {

    private var window: NSWindow?
    private let store = OverlayStateStore()

    private var host: NSHostingController<OverlayView>?

    func show() {

        guard window == nil else { return }
        
        let host = NSHostingController(
            rootView: OverlayView(store: store)
        )

        let window = NSWindow(
            contentRect: NSRect(
                x: 0,
                y: 0,
                width: 120,
                height: 34
            ),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        window.backgroundColor = .clear
        window.isOpaque = false
        window.hasShadow = false

        // Keep the overlay above fullscreen applications
        window.level = NSWindow.Level(
            rawValue: NSWindow.Level.screenSaver.rawValue - 1
        )

        window.ignoresMouseEvents = true
        window.hidesOnDeactivate = false

        window.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
            .stationary,
            .ignoresCycle
        ]

        window.contentViewController = host

        if let screen = NSScreen.main {

            let frame = screen.visibleFrame

            window.setFrameOrigin(
                CGPoint(
                    x: frame.midX - 60,
                    y: 48
                )
            )
        }

        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()

        self.window = window
        self.host = host
    }

    func setState(_ state: OverlayState) {
        store.state = state
    }

    func updateLevel(_ level: CGFloat) {
        store.audioLevel = level
    }

    func hide() {

        window?.orderOut(nil)
        window = nil
        host = nil
    }
}
