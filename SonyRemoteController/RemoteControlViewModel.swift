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
    @Published var isOn: Bool = false
    @Published var requestStatus: String? = nil
    @Published var isLoading: Bool = false

    private let deviceRepository: DeviceRepository
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
}
