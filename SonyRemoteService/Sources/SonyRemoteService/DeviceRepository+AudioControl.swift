//
//  DeviceRepository+AudioControl.swift
//  SonyRemoteService
//
//  Created by xupan on 2025/8/16.
//

public struct AudioResultItem: Decodable, Sendable {}

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
        let parameters = api.makeParameters(params: ["volume": volume])
        apiService.post(path, parameters: parameters) { result
            in
            completion(result)
        }
    }
}