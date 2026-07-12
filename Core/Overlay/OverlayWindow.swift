//
//  OverlayWindow.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import AppKit
import SwiftUI

final class OverlayWindow {

    private var window: NSWindow?

    func show() {

        guard window == nil else {
            return
        }

        let hosting = NSHostingView(rootView: OverlayView())

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 260, height: 70),
            styleMask: .borderless,
            backing: .buffered,
            defer: false
        )

        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .floating
        window.hasShadow = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.ignoresMouseEvents = true

        window.contentView = hosting

        if let screen = NSScreen.main {

            let frame = screen.visibleFrame

            window.setFrameOrigin(
                CGPoint(
                    x: frame.midX - 130,
                    y: 80
                )
            )

        }

        window.makeKeyAndOrderFront(nil)

        self.window = window

    }

    func hide() {

        window?.orderOut(nil)

        window = nil

    }

}