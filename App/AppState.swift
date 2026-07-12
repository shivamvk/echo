//
//  AppState.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import Foundation

@MainActor
final class AppState: ObservableObject {

    let recorder = MicrophoneRecorder()
    let coordinator = RecordingCoordinator()
    let hotkey = HotkeyService()

    init() {

        hotkey.onKeyDown = { [weak self] in

            guard let self else { return }

            print("🎤 FN DOWN")

            do {
                try self.recorder.start()
            } catch {
                print(error)
            }
        }

        hotkey.onKeyUp = { [weak self] in

            guard let self else { return }

            print("🛑 FN UP")

            Task {

                do {

                    let url = try self.recorder.stop()

                    try await self.coordinator.process(audioURL: url)

                } catch {

                    print(error)

                }

            }
        }

        hotkey.start()
    }
}