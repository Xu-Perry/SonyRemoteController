//
//  DeviceRepository+AppControl.swift
//  SonyRemoteService
//
//  Created by xupan on 2025/8/16.
//

public struct AppControlResultItem: Decodable, Sendable {}

public extension DeviceRepository {
    /// 设置活动应用
    /// - Parameters:
    ///   - appId: 应用ID
    ///   - completion: 完成回调
    func setActiveApp(
        api: SonyAPIList = .setActiveApp,
        appId: String,
        completion: @escaping @Sendable (
            Result<SonyServiceResponse<AppControlResultItem>, APIError>
        ) -> Void
    ) {
        let path = api.makeURLPath()
        let parameters = api.makeParameters(params: ["appId": appId])
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
    
    /// 终止应用
    /// - Parameters:
    ///   - appIds: 应用ID数组
    ///   - completion: 完成回调
    func terminateApps(
        api: SonyAPIList = .terminateApps,
        appIds: [String],
        completion: @escaping @Sendable (
            Result<SonyServiceResponse<AppControlResultItem>, APIError>
        ) -> Void
    ) {
        let path = api.makeURLPath()
        let parameters = api.makeParameters(params: ["appIds": appIds])
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
}