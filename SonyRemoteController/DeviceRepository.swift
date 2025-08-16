//
//  DeviceRepository.swift
//  SonyRemoteController
//
//  Created by xupan on 2025/8/16.
//

import Foundation
import SonyRemoteService

// 创建一个新的结构体来表示 result 数组中的元素
struct PowerStatusResultItem: Decodable {
    let status: Bool
}

// 修改 SonyServiceResponse 结构体
struct PowerStatusResponse: Decodable {
    let id: Int
    let result: [PowerStatusResultItem]
}

class DeviceRepository {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    /// 设置设备电源状态
    /// - Parameters:
    ///   - status: true 表示开机，false 表示关机
    ///   - completion: 完成回调
    func setPowerStatus(_ status: Bool, completion: @escaping (Result<Void, APIError>) -> Void) {
        let parameters: [String: Any] = [
            "method": "setPowerStatus",
            "version": "1.0",
            "id": 1,
            "params": [
                [
                    "status": status
                ]
            ]
        ]

        apiService.post("sony/system", parameters: parameters) { 
            (result: Result<PowerStatusResponse, APIError>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
