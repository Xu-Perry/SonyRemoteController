//
//  DeviceRepository+AudioControl.swift
//  SonyRemoteService
//
//  Created by xupan on 2025/8/16.
//

public struct AudioResultItem: Decodable, Sendable {}

// 添加音量信息结构体
public struct VolumeInformation: Decodable, Sendable {
    public let volume: Int
    public let minVolume: Int
    public let maxVolume: Int
    public let mute: Bool
    public let target: String
}

public extension DeviceRepository {
    /// 设置音频静音状态
    /// - Parameters:
    ///   - mute: true 表示静音，false 表示取消静音
    ///   - completion: 完成回调
    func setAudioMute(
        api: SonyAPIList = .setAudioMute,
        _ mute: Bool,
        completion: @escaping @Sendable (
            Result<SonyServiceResponse<AudioResultItem>, APIError>
        ) -> Void
    ) {
        let path = api.makeURLPath()
        let parameters = api.makeParameters(params: ["mute": mute])
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
    
    /// 设置音频音量
    /// - Parameters:
    ///   - volume: 音量值 (0-100)
    ///   - completion: 完成回调
    func setAudioVolume(
        api: SonyAPIList = .setAudioVolume,
        _ volume: Int,
        completion: @escaping @Sendable (
            Result<SonyServiceResponse<AudioResultItem>, APIError>
        ) -> Void
    ) {
        let path = api.makeURLPath()
        let parameters = api.makeParameters(
            params: ["volume": String(volume), "ui": "on", "target": "speaker"],
            version: "1.2"
        )
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
    
    /// 获取音量信息
    /// - Parameters:
    ///   - api: API 枚举值
    ///   - completion: 完成回调
    func getVolumeInformation(
        api: SonyAPIList = .getVolumeInformation,
        completion: @escaping @Sendable (
            Result<SonyServiceResponse<[VolumeInformation]>, APIError>
        ) -> Void
    ) {
        let path = api.makeURLPath()
        let parameters = api.makeParameters(params: nil, version: "1.0")
        apiService.post(path, parameters: parameters) { result in
            completion(result)
        }
    }
}
