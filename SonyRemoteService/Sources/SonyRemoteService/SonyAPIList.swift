//
//  SonyAPIList.swift
//  SonyRemoteService
//
//  Created by xupan on 2025/8/16.
//

import Foundation

public enum SonyAPIList: String {
    case setPowerStatus
}


extension SonyAPIList {
    
    func makeURLPath() -> String {
        switch self {
            case .setPowerStatus:
                return ""
            default:
                fatalError()
        }
    }
    
    func makeParameters<T>(params: T, version: String = "1.0", id: Int = 1) -> [String: Any & Sendable] where T: Codable, T: Sendable {
        switch self {
            case .setPowerStatus:
                return [
                    "method": self.rawValue,
                    "version": version,
                    "id": id,
                    "params": params
                ]
            default:
                fatalError()
        }
    }
}
