import SwiftUI

struct WelcomeView: View {
    
    let onFinish: () -> Void
    
    @StateObject
    private var viewModel = OnboardingViewModel()
    
    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

    var body: some View {

        VStack(spacing: 28) {

            Spacer(minLength: 10)

            Image("EchoLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 92, height: 92)

            VStack(spacing: 10) {

                Text("Welcome to Echo")
                    .font(.system(size: 34, weight: .bold))

                Text("Press and hold Fn to dictate anywhere on your Mac.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

            }

            VStack(spacing: 14) {

                SetupCard(
                    title: "Accessibility",
                    description: "Required to paste text into any application.",
                    buttonTitle: viewModel.accessibilityGranted ? "Granted ✓" : "Grant Access",
                    isCompleted: viewModel.accessibilityGranted
                ) {

                    viewModel.requestAccessibility()

                }

                SetupCard(
                    title: "Microphone",
                    description: "Required to record your voice.",
                    buttonTitle: viewModel.microphoneGranted ? "Granted ✓" : "Grant Access",
                    isCompleted: viewModel.microphoneGranted
                ) {

                    viewModel.requestMicrophone()

                }

            }

            Spacer()
            
            Button("Start Using Echo") {
                onFinish()
                print("✅ Onboarding completed:", hasCompletedOnboarding)

                NSApp.keyWindow?.close()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(!viewModel.canContinue)

        }
        .padding(36)
        .frame(width: 560, height: 700)
    }
}

private struct SetupCard: View {

    let title: String
    let description: String
    let buttonTitle: String
    let isCompleted: Bool
    let action: () -> Void

    var body: some View {

        HStack(alignment: .center, spacing: 16) {

            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundStyle(isCompleted ? .green : .orange)

            VStack(alignment: .leading, spacing: 6) {

                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

            }

            Spacer()

            Button(buttonTitle) {
                action()
            }
            .buttonStyle(.borderedProminent)
            .tint(isCompleted ? .green : .accentColor)
            .buttonStyle(.bordered)

        }
        .padding(18)
        .background(Color(NSColor.controlBackgroundColor))
        .clipShape(
            RoundedRectangle(cornerRadius: 14)
        )

    }
}
