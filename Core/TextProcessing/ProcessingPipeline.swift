final class ProcessingPipeline {

    private let processor: TextProcessor

    init(
        processor: TextProcessor = PassthroughProcessor()
    ) {

        self.processor = processor

    }

    func process(_ text: String) async throws -> String {

        try await processor.process(text)

    }

}