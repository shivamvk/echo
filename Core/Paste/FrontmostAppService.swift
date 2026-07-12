//
//  FrontmostAppService.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import AppKit

final class FrontmostAppService {

    private var previousApp: NSRunningApplication?

    func saveCurrentApp() {
        previousApp = NSWorkspace.shared.frontmostApplication
    }

    func restorePreviousApp() {
        previousApp?.activate(options: [.activateIgnoringOtherApps])
    }
}