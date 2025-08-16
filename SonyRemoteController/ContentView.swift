//
//  ContentView.swift
//  SonyRemoteController
//
//  Created by xupan on 2025/8/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DependencyContainer.shared.remoteControlViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Sony Remote Controller")
                .font(.title)
                .padding()

            Button(viewModel.isOn ? "Turn Off" : "Turn On") {
                viewModel.togglePower()
            }
            .padding()
            .background(viewModel.isOn ? .red : .green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(viewModel.isLoading)

            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let status = viewModel.requestStatus {
                Text(status)
                    .padding()
                    .foregroundColor(status.contains("Error") ? .red : .green)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
