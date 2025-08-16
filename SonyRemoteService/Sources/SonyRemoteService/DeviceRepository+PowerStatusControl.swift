//
//  DeviceRepository+PowerStatusControl.swift
//  SonyRemoteService
//
//  Created by xupan on 2025/8/16.
//

public struct PowerStatusResultItem: Decodable, Sendable {}

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
        let parameters = api.makeParameters(params: [["status": status]])
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
}
