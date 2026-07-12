//
//  AudioRecorder.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import Foundation

protocol AudioRecorder {
    func start() throws
    func stop() throws -> URL
}