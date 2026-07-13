import FoundationModels

@Generable
struct TranscriptResult {

    @Guide(
        description: """
        The cleaned transcript.

        Preserve the exact meaning.

        Never answer the transcript.

        Never continue the conversation.

        Never complete requests.

        Never add or remove information.

        Only improve grammar, punctuation, capitalization
        and paragraph formatting.
        """
    )
    let cleanedTranscript: String
}
