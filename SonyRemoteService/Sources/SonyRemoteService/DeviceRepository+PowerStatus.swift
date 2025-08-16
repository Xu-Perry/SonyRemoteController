//
//  DeviceRepository+PowerStatus.swift
//  SonyRemoteService
//
//  Created by xupan on 2025/8/16.
//

public struct PowerStatusResultItem: Decodable, Sendable {}

public struct GetPowerStatusResultItem: Decodable, Sendable {
    public let status: String
}

public extension DeviceRepository {
    /// 设置设备电源状态
    /// - Parameters:
    ///   - status: true 表示开机，false 表示关机
    ///   - completion: 完成回调
    func setPowerStatus(
        api: SonyAPIList = .setPowerStatus,
        _ status: Bool,
        completion: @escaping @Sendable (
            Result<SonyServiceResponse<PowerStatusResultItem>, APIError>
        ) -> Void
    ) {
        let path = api.makeURLPath()
        let parameters = api.makeParameters(params: ["status": status])
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
    
    /// 获取设备电源状态
    /// - Parameters:
    ///   - completion: 完成回调
    func getPowerStatus(
        api: SonyAPIList = .getPowerStatus,
        completion: @escaping @Sendable (
            Result<SonyServiceResponse<GetPowerStatusResultItem>, APIError>
        ) -> Void
    ) {
        let path = api.makeURLPath()
        let parameters = api.makeParameters(params: nil)
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
}
