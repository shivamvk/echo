//
//  MicrophoneRecorder.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import AVFoundation

final class MicrophoneRecorder: AudioRecorder {

    private let engine = AVAudioEngine()
    private var audioFile: AVAudioFile?
    private var outputURL: URL?

    func start() throws {

        let directory = FileManager.default.temporaryDirectory
        let fileURL = directory.appendingPathComponent("echo-recording.wav")

        outputURL = fileURL

        let input = engine.inputNode
        let format = input.outputFormat(forBus: 0)

        audioFile = try AVAudioFile(
            forWriting: fileURL,
            settings: format.settings
        )

        input.removeTap(onBus: 0)

        input.installTap(
            onBus: 0,
            bufferSize: 4096,
            format: format
        ) { [weak self] buffer, _ in

            try? self?.audioFile?.write(from: buffer)

        }

        engine.prepare()
        try engine.start()
    }

    func stop() throws -> URL {

        engine.stop()

        engine.inputNode.removeTap(onBus: 0)

        guard let url = outputURL else {
            throw NSError(
                domain: "Echo",
                code: -1
            )
        }

        return url
    }

}