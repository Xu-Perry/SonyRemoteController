//
//  RemoteControlView.swift
//  SonyRemoteController
//
//  Created by xupan on 2025/8/16.
//

import SwiftUI

struct RemoteControlView: View {
    @StateObject private var viewModel = DependencyContainer.shared.remoteControlViewModel

    var body: some View {
        VStack {
            // 标题和状态显示
            Text("Sony Remote Controller")
                .font(.title)
                .padding()

            // 电源状态和控制
            HStack {
                Text("Power: ")
                    .font(.headline)
                Text(viewModel.isOn ? "On" : "Off")
                    .font(.headline)
                    .foregroundColor(viewModel.isOn ? .green : .red)
            }
            .padding()

            Button(viewModel.isOn ? "Turn Off" : "Turn On") {
                viewModel.togglePower()
            }
            .padding()
            .background(viewModel.isOn ? .red : .green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(viewModel.isLoading)

            // 音量控制
            VStack {
                Text("Volume Control (\(viewModel.currentVolume))")
                    .font(.headline)
                    .padding()

                HStack {
                    Button("- Volume") {
                        viewModel.volumeDown()
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("+ Volume") {
                        viewModel.volumeUp()
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()

            // 频道控制
            VStack {
                Text("Channel Control (\(viewModel.currentChannel))")
                    .font(.headline)
                    .padding()

                HStack {
                    Button("- Channel") {
                        viewModel.channelDown()
                    }
                    .padding()
                    .background(.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("+ Channel") {
                        viewModel.channelUp()
                    }
                    .padding()
                    .background(.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()

            // 方向键控制
            VStack {
                Text("Navigation")
                    .font(.headline)
                    .padding()

                VStack(spacing: 10) {
                    Button("Up") {
                        viewModel.sendNavigationCommand("up")
                    }
                    .padding()
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    HStack(spacing: 10) {
                        Button("Left") {
                            viewModel.sendNavigationCommand("left")
                        }
                        .padding()
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("OK") {
                            viewModel.sendNavigationCommand("confirm")
                        }
                        .padding()
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("Right") {
                            viewModel.sendNavigationCommand("right")
                        }
                        .padding()
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

                    Button("Down") {
                        viewModel.sendNavigationCommand("down")
                    }
                    .padding()
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()

            // 菜单和返回按钮
            HStack {
                Button("Menu") {
                    viewModel.sendNavigationCommand("menu")
                }
                .padding()
                .background(.yellow)
                .foregroundColor(.black)
                .cornerRadius(10)

                Button("Back") {
                    viewModel.sendNavigationCommand("back")
                }
                .padding()
                .background(.yellow)
                .foregroundColor(.black)
                .cornerRadius(10)
            }
            .padding()

            // 状态信息
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
        .onAppear {
            viewModel.getPowerStatus()
        }
    }
}

#Preview {
    RemoteControlView()
}
