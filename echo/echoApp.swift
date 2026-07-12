import SwiftUI

@main
struct echoApp: App {
    var body: some Scene {
        MenuBarExtra("Echo", systemImage: "waveform") {
            VStack(alignment: .leading, spacing: 12) {
                Text("Echo")

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
