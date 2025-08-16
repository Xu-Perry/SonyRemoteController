//
//  SonyAPIList.swift
//  SonyRemoteService
//
//  Created by xupan on 2025/8/16.
//

import Foundation

public enum SonyAPIList: String {
    case setPowerStatus
    case getPowerStatus
    case setPlayContent
    case setAudioMute
    case setAudioVolume
    case setSceneSetting
    case setActiveApp
    case terminateApps
    case getVolumeInformation  // 添加新的枚举值
}


extension SonyAPIList {
    
    func makeURLPath() -> String {
        switch self {
            case .setPowerStatus,
                 .getPowerStatus:
                return "sony/system"
            case .setPlayContent:
                return "sony/avContent"
            case .setAudioMute,
                    .setAudioVolume,
                    .getVolumeInformation:
                return "sony/audio"
            case .setSceneSetting:
                return "sony/sceneSetting"
            case .setActiveApp,
                 .terminateApps:
                return "sony/appControl"
            default:
                fatalError()
        }
    }
    
    func makeParameters(params: [String: Any & Sendable]?, version: String = "1.0", id: Int = 1) -> [String: Any & Sendable] {
        switch self {
            case .setPowerStatus,
                 .getPowerStatus,
                 .setPlayContent,
                 .setAudioMute,
                 .setAudioVolume,
                 .setSceneSetting,
                 .setActiveApp,
                 .terminateApps,
                 .getVolumeInformation:  // 添加新的 case
                return [
                    "method": self.rawValue,
                    "version": version,
                    "id": id,
                    "params": params == nil ? [String]() : [params]
                ]
            default:
                fatalError()
        }
    }
}
