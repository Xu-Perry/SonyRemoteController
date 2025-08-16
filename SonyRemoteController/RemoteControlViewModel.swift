//
//  RemoteControlViewModel.swift
//  SonyRemoteController
//
//  Created by xupan on 2025/8/16.
//

import Foundation
import Combine
import SonyRemoteService

class RemoteControlViewModel: ObservableObject {
    @Published var isOn: Bool = false {
        didSet {
            getCurrentVolumn()
        }
    }
    @Published var requestStatus: String? = nil
    @Published var isLoading: Bool = false
    @Published var currentVolume: Int = 50
    @Published var currentChannel: Int = 1

    let deviceRepository: DeviceRepository
    private var cancellables = Set<AnyCancellable>()

    init(deviceRepository: DeviceRepository) {
        self.deviceRepository = deviceRepository
    }
    

    func getPowerStatus() {
        isLoading = true
        deviceRepository.getPowerStatus { [weak self] result in
            guard let self = self else { return }

            self.isLoading = false
            switch result {
                case let .success(response):
                    self.isOn = (response.result.last?.status ?? "standby") != "standby"
            case .failure(let error):
                self.requestStatus = "Error: \(error.localizedDescription)"
            }
        }
    }
    
    /// 切换电源状态
    func togglePower() {
        isLoading = true
        let newStatus = !isOn

        deviceRepository.setPowerStatus(newStatus) {
            [weak self] result in
            guard let self = self else { return }

            self.isLoading = false
            switch result {
            case .success:
                self.isOn = newStatus
                self.requestStatus = "Success: TV \(newStatus ? "turned on" : "turned off")"
            case .failure(let error):
                self.requestStatus = "Error: \(error.localizedDescription)"
            }
        }
    }

    

    /// 频道增加
    func channelUp() {
//        guard isOn else { return }
//        isLoading = true
//        let newChannel = currentChannel + 1

//        deviceRepository.setChannel(newChannel) { [weak self] result in
//            guard let self = self else { return }
//            self.isLoading = false
//            switch result {
//            case .success:
//                self.currentChannel = newChannel
//                self.requestStatus = "Channel: \(newChannel)"
//            case .failure(let error):
//                self.requestStatus = "Error: \(error.localizedDescription)"
//            }
//        }
    }

    /// 频道减少
    func channelDown() {
//        guard isOn else { return }
//        isLoading = true
//        let newChannel = max(currentChannel - 1, 1)
//
//        deviceRepository.setChannel(newChannel) { [weak self] result in
//            guard let self = self else { return }
//            self.isLoading = false
//            switch result {
//            case .success:
//                self.currentChannel = newChannel
//                self.requestStatus = "Channel: \(newChannel)"
//            case .failure(let error):
//                self.requestStatus = "Error: \(error.localizedDescription)"
//            }
//        }
    }

    /// 发送导航命令
    func sendNavigationCommand(_ command: String) {
//        guard isOn else { return }
//        isLoading = true
//
//        deviceRepository.sendNavigationCommand(command) { [weak self] result in
//            guard let self = self else { return }
//            self.isLoading = false
//            switch result {
//            case .success:
//                self.requestStatus = "\(command.capitalized) command sent"
//            case .failure(let error):
//                self.requestStatus = "Error: \(error.localizedDescription)"
//            }
//        }
    }
}
