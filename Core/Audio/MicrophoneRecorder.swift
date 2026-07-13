import Foundation
import AVFoundation
import CoreGraphics

final class MicrophoneRecorder: NSObject, AudioRecorder {

    private var recorder: AVAudioRecorder?
    private var outputURL: URL?
    var onAudioLevel: ((CGFloat) -> Void)?
    
    
    private var meterTimer: Timer?

    func start() throws {

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("m4a")

        outputURL = url

        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        recorder = try AVAudioRecorder(url: url, settings: settings)
        
        recorder?.isMeteringEnabled = true

        recorder?.prepareToRecord()
        recorder?.record()
        
        meterTimer = Timer.scheduledTimer(
            withTimeInterval: 0.03,
            repeats: true
        ) { [weak self] _ in

            guard let self else { return }

            guard let recorder = self.recorder else { return }

            recorder.updateMeters()

            let power = recorder.averagePower(forChannel: 0)

            let minDb: Float = -60

            let level = max(
                0,
                (power - minDb) / abs(minDb)
            )

            DispatchQueue.main.async {

                self.onAudioLevel?(CGFloat(level))

            }

        }
        
    }

    func stop() throws -> URL {
        
        meterTimer?.invalidate()

        meterTimer = nil

        onAudioLevel?(0)

        recorder?.stop()

        guard let outputURL else {
            throw NSError(domain: "Echo", code: -1)
        }

        return outputURL
    }
}
