//
//  WhisperService.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import Foundation
import WhisperKit

@MainActor
final class WhisperService {

    private var whisperKit: WhisperKit?

    func load() async throws {

        if whisperKit != nil {
            return
        }

        whisperKit = try await WhisperKit()

    }

    func transcribe(audioURL: URL) async throws -> String {

        try await load()

        guard let whisperKit else {
            return ""
        }

        let results = try await whisperKit.transcribe(audioPath: audioURL.path)

        return results
            .map(\.text)
            .joined(separator: " ")

    }
}