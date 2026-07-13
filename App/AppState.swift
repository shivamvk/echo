import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {

    let recorder = MicrophoneRecorder()
    let coordinator = RecordingCoordinator()
    let hotkey = HotkeyService()
    let appService = FrontmostAppService()
    let overlay = OverlayManager()
    
    private let updater = UpdateService.shared

    init() {

        if !AccessibilityService.ensurePermission() {
            print("❌ Accessibility permission missing")
            return
        }

        print("✅ Accessibility permission granted")
        
        recorder.onAudioLevel = { [weak self] level in

            self?.overlay.updateLevel(level)

        }

        hotkey.onKeyDown = { [weak self] in

            guard let self else { return }

            self.overlay.show()
            self.overlay.listening()

            self.appService.saveCurrentApp()

            do {
                try self.recorder.start()
            } catch {
                print(error)
            }
        }

        hotkey.onKeyUp = { [weak self] in

            guard let self else { return }

            Task {

                do {

                    let url = try self.recorder.stop()

                    self.overlay.processing()

                    self.appService.restorePreviousApp()

                    try? await Task.sleep(for: .milliseconds(250))

                    try await self.coordinator.process(audioURL: url)

                    self.overlay.hide()

                } catch {

                    self.overlay.hide()

                    print(error)

                }

            }

        }

        hotkey.start()
    }
}
