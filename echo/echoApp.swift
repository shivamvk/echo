import SwiftUI

@main
struct echoApp: App {

    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

    @State
    private var appState: AppState?

    init() {

        NSApplication.shared.setActivationPolicy(.accessory)
        
        if UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
            _appState = State(initialValue: AppState())
        }

    }

    var body: some Scene {

        WindowGroup {

            if hasCompletedOnboarding {

                EmptyView()

            } else {

                WelcomeView {

                    hasCompletedOnboarding = true
                    appState = AppState()

                    NSApp.keyWindow?.close()

                }

            }

        }
        .windowResizability(.contentSize)

        MenuBarExtra("Echo", systemImage: "waveform") {

            VStack(spacing: 12) {

                Text("Echo Running")

                Divider()

                Button("Check for Updates…") {
                    UpdateService.shared.checkForUpdates()
                }

                Divider()

                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }

            }
            .padding()
            .frame(width: 220)

        }

    }
}
