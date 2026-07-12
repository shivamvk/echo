//
//  AccessibilityService.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import ApplicationServices

final class AccessibilityService {

    static func ensurePermission() -> Bool {

        let options = [
            kAXTrustedCheckOptionPrompt.takeRetainedValue() as String: true
        ] as CFDictionary

        return AXIsProcessTrustedWithOptions(options)
    }
}