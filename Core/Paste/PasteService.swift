//
//  PasteService.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import AppKit

final class PasteService {

    func paste(_ text: String) {

        let pasteboard = NSPasteboard.general

        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)

        let source = CGEventSource(stateID: .combinedSessionState)

        let commandDown = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x37,
            keyDown: true
        )

        let vDown = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x09,
            keyDown: true
        )

        let vUp = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x09,
            keyDown: false
        )

        let commandUp = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x37,
            keyDown: false
        )

        vDown?.flags = .maskCommand
        vUp?.flags = .maskCommand

        commandDown?.post(tap: .cghidEventTap)
        vDown?.post(tap: .cghidEventTap)
        vUp?.post(tap: .cghidEventTap)
        commandUp?.post(tap: .cghidEventTap)
    }
}