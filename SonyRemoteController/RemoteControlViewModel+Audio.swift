//
//  RemoteControlViewModel+Audio.swift
//  SonyRemoteController
//
//  Created by xupan on 2025/8/16.
//

import SonyRemoteService


extension RemoteControlViewModel {
    /// 音量增加
    func volumeUp() {
        guard isOn else { return }
        isLoading = true
        let newVolume = min(currentVolume + 5, 100)

        deviceRepository.setAudioVolume(newVolume) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success:
                self.currentVolume = newVolume
                self.requestStatus = "Volume: \(newVolume)"
            case .failure(let error):
                self.requestStatus = "Error: \(error.localizedDescription)"
            }
        }
    }

    /// 音量减少
    func volumeDown() {
        guard isOn else { return }
        isLoading = true
        let newVolume = max(currentVolume - 5, 0)

        deviceRepository.setAudioVolume(newVolume) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success:
                    self.currentVolume = newVolume
                self.requestStatus = "Volume: \(newVolume)"
            case .failure(let error):
                self.requestStatus = "Error: \(error.localizedDescription)"
            }
        }
    }
    
    func getCurrentVolumn() {
        isLoading = true
        deviceRepository
            .getVolumeInformation() { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case let .success(response):
                    self.currentVolume = response.result.last?.filter({
                        $0.target == "speaker"
                    }).last?.volume ?? 0
            case .failure(let error):
                self.requestStatus = "Error: \(error.localizedDescription)"
            }
        }
    }
}
