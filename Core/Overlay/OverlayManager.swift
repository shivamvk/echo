//
//  OverlayManager.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


final class OverlayManager {

    private let window = OverlayWindow()

    func show() {
        window.show()
    }

    func hide() {
        window.hide()
    }

}