import Foundation
import WhisperKit

@MainActor
final class WhisperService {

    private var whisperKit: WhisperKit?

    func load() async throws {

        print("Loading WhisperKit...")

        do {
            if whisperKit == nil {
                whisperKit = try await WhisperKit()
            }
        } catch {
            print("WHISPER KIT ERROR")
            print(error)
        }
 
        print("WhisperKit Loaded")
    }

    func transcribe(audioURL: URL) async throws -> String {

        print("Transcribe called")

        try await load()

        guard let whisperKit else {
            throw NSError(domain: "Echo", code: -1)
        }

        print("Starting transcription...")

        let results = try await whisperKit.transcribe(audioPath: audioURL.path)

        print("Finished transcription")

        return results.map(\.text).joined(separator: " ")
    }
}
