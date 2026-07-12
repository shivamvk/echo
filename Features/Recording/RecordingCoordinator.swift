//
//  RecordingCoordinator.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import Foundation

final class RecordingCoordinator {

    private let recognizer: SpeechRecognizer

    init(recognizer: SpeechRecognizer) {
        self.recognizer = recognizer
    }

    func process(audioURL: URL) async throws -> String {
        try await recognizer.transcribe(audioURL: audioURL)
    }
}