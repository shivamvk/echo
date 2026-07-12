//
//  HotkeyService.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import Carbon
import Foundation

final class HotkeyService {

    private var eventMonitor: Any?

    var onKeyDown: (() -> Void)?
    var onKeyUp: (() -> Void)?

    private var isPressed = false

    func start() {

        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { [weak self] event in

            guard let self else { return }

            let fnPressed = event.modifierFlags.contains(.function)

            if fnPressed && !isPressed {

                isPressed = true
                onKeyDown?()

            } else if !fnPressed && isPressed {

                isPressed = false
                onKeyUp?()

            }

        }

    }

}