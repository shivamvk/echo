import AppKit

final class HotkeyService {

    private var eventMonitor: Any?

    var onKeyDown: (() -> Void)?
    var onKeyUp: (() -> Void)?

    private var isPressed = false

    func start() {

        eventMonitor = NSEvent.addGlobalMonitorForEvents(
            matching: [.flagsChanged]
        ) { [weak self] event in

            guard let self else { return }

            let fnPressed = event.modifierFlags.contains(.function)

            if fnPressed && !isPressed {

                isPressed = true
                onKeyDown?()

            } else if !fnPressed && isPressed {

                isPressed = false
                onKeyUp?()

            }
        }
    }
}
