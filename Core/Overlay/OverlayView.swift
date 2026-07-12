//
//  OverlayView.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


import SwiftUI

struct OverlayView: View {

    var body: some View {

        HStack(spacing: 12) {

            Image(systemName: "waveform")

                .font(.title2)

            Text("Listening...")

                .font(.headline)

        }
        .padding(.horizontal, 22)
        .padding(.vertical, 14)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(radius: 20)

    }

}