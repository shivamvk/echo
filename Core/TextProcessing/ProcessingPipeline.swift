import Foundation

final class ProcessingPipeline {

    private let processor: TextProcessor = FoundationModelProcessor()

    func process(_ text: String) async throws -> String {
        try await processor.process(text)
    }
}


