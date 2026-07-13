import AppKit

final class PasteService {

    func paste(_ text: String) {

        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString(text, forType: .string)

        guard let app = NSWorkspace.shared.frontmostApplication else {
            print("No frontmost app")
            return
        }

        print("Frontmost:", app.localizedName ?? "")
        print("PID:", app.processIdentifier)

        let source = CGEventSource(stateID: .combinedSessionState)

        let cmdDown = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x37,
            keyDown: true
        )

        let vDown = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x09,
            keyDown: true
        )

        let vUp = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x09,
            keyDown: false
        )

        let cmdUp = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x37,
            keyDown: false
        )

        cmdDown?.flags = .maskCommand
        vDown?.flags = .maskCommand
        vUp?.flags = .maskCommand
        cmdUp?.flags = .maskCommand

        cmdDown?.postToPid(app.processIdentifier)
        usleep(10000)

        vDown?.postToPid(app.processIdentifier)
        usleep(10000)

        vUp?.postToPid(app.processIdentifier)
        usleep(10000)

        cmdUp?.postToPid(app.processIdentifier)

        print("Paste events posted")
    }
}
