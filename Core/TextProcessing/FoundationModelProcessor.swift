//
//  FoundationModelProcessor.swift
//  echo
//
//  Created by Shivam Bhasin on 12/07/26.
//


import Foundation
import FoundationModels

final class FoundationModelProcessor: TextProcessor {

    private let session: LanguageModelSession

    init() {

        session = LanguageModelSession()

    }

    func process(_ text: String) async throws -> String {

        let prompt = """
        \(Prompt.cleanup)

        Transcript:

        \(text)
        """

        let response = try await session.respond(
            to: prompt
        )

        return response.content

    }

}