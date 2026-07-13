//
//  MicrophonePermission.swift
//  echo
//
//  Created by Shivam Bhasin on 12/07/26.
//


import AVFoundation

enum MicrophonePermission {

    static var isGranted: Bool {

        AVCaptureDevice.authorizationStatus(for: .audio) == .authorized

    }

    static func request() async {

        _ = await AVCaptureDevice.requestAccess(for: .audio)

    }
}