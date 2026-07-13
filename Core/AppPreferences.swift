//
//  AppPreferences.swift
//  echo
//
//  Created by Shivam Bhasin on 12/07/26.
//


import Foundation

enum AppPreferences {

    private static let onboardingKey = "hasCompletedOnboarding"

    static var hasCompletedOnboarding: Bool {
        get {
            UserDefaults.standard.bool(forKey: onboardingKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: onboardingKey)
        }
    }
}