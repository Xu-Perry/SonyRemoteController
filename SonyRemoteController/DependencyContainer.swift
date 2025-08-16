//
//  DependencyContainer.swift
//  SonyRemoteController
//
//  Created by xupan on 2025/8/16.
//

import Foundation
import SonyRemoteService

class DependencyContainer {
    static let shared = DependencyContainer()

    lazy var apiService: APIService = {
        return APIService(baseURL: "http://192.168.0.195", authPSK: "xupan")
    }()

    lazy var deviceRepository: DeviceRepository = {
        return DeviceRepository(apiService: apiService)
    }()

    lazy var remoteControlViewModel: RemoteControlViewModel = {
        return RemoteControlViewModel(deviceRepository: deviceRepository)
    }()
}
