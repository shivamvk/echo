import Foundation
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {

    @Published
    var accessibilityGranted = AccessibilityPermission.isGranted
    
    @Published
    var microphoneGranted = MicrophonePermission.isGranted

    var canContinue: Bool {
        accessibilityGranted &&
        microphoneGranted
    }

    func requestAccessibility() {

        AccessibilityPermission.request()

        Task {
            try? await Task.sleep(for: .seconds(1))
            accessibilityGranted = AccessibilityPermission.isGranted
        }
    }
    
    func requestMicrophone() {

        Task {

            await MicrophonePermission.request()

            microphoneGranted = MicrophonePermission.isGranted

        }

    }
}
