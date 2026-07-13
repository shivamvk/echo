//
//  AccessibilityPermission.swift
//  echo
//
//  Created by Shivam Bhasin on 12/07/26.
//


import ApplicationServices

enum AccessibilityPermission {

    static var isGranted: Bool {
        AXIsProcessTrusted()
    }

    static func request() {

        let options = [
            kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true
        ]

        AXIsProcessTrustedWithOptions(options as CFDictionary)
    }
}