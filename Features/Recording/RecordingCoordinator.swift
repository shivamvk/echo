import Foundation

@MainActor
final class RecordingCoordinator {

    private let whisper = WhisperService()
    private let pipeline = ProcessingPipeline()
    private let pasteService = PasteService()

    func process(audioURL: URL) async throws {

        let transcript = try await whisper.transcribe(audioURL: audioURL)

        print("Raw Transcript:")
        print(transcript)

        let cleaned = try await pipeline.process(transcript)

        print("Processed Transcript:")
        print(cleaned)
        
        pasteService.paste(cleaned)

    }

}
