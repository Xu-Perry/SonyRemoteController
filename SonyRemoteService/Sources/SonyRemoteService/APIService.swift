//
//  APIService.swift
//  SonyRemoteController
//
//  Created by xupan on 2025/8/16.
//

import Foundation
import Alamofire
import OSLog

// 修改 PowerStatusResponse 结构体
public struct SonyServiceResponse<T>: Decodable, Sendable where T: Sendable, T: Decodable {
    public let id: Int
    public let result: [T]
}

public enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

public class APIService {
    private let baseURL: String
    private let authPSK: String
    private let session: Session

    public init(baseURL: String, authPSK: String) {
        self.baseURL = baseURL
        self.authPSK = authPSK
        self.session = Session(configuration: .default)
    }

    /// 发送 POST 请求
    /// - Parameters:
    ///   - endpoint: API 端点
    ///   - parameters: 请求参数
    ///   - completion: 完成回调
    func post<T>(
        _ endpoint: String,
        parameters: [String: Any & Sendable],
        completion: @escaping @Sendable (Result<T, APIError>) -> Void
    ) where T: Decodable, T: Sendable {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            completion(.failure(.invalidURL))
            return
        }

        let headers: HTTPHeaders = [
            "X-Auth-PSK": authPSK,
            "Content-Type": "application/json"
        ]
        
        
        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        if let paramsString = String(
            data: data,
            encoding: .utf8
        ) {
            os_log(
                .debug,
                log: .default,
                "url: \(url.absoluteString) \n params: \(paramsString)"
            )
        }
        
        session.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) {
                response in
                os_log(
                    .info,
                    log: .default,
                    "result: \(String(data: response.data!, encoding: .utf8)!)"
                )
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    if let underlyingError = error.underlyingError {
                        completion(.failure(.requestFailed(underlyingError)))
                    } else {
                        completion(.failure(.invalidResponse))
                    }
                }
            }
    }
}
