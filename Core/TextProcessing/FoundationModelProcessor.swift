import Foundation
import FoundationModels

final class FoundationModelProcessor: TextProcessor {

    private let session = LanguageModelSession(
        instructions: Prompt.cleanup
    )

    func process(_ text: String) async throws -> String {

        print("🤖 Processing with Apple Intelligence...")
        print("Input:", text)

        let response = try await session.respond(
            to: """
            Transcript:

            \(text)

            Return only the cleaned transcript.
            """,
            generating: TranscriptResult.self
        )
        

        print("Output:", response.content.cleanedTranscript)

        return response.content.cleanedTranscript
    }
}

