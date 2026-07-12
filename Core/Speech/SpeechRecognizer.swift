//
//  SpeechRecognizer.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import Foundation

protocol SpeechRecognizer {
    func transcribe(audioURL: URL) async throws -> String
}