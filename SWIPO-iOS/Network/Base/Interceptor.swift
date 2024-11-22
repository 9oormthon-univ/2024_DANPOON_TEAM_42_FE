//
//  Interceptor.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = KeyChainManager.readItem(key: "accessToken") else {
            
            completion(.failure(AuthError.noToken))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization("Bearer \(accessToken)"))
        print("JWT: \(accessToken)")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        if response.statusCode == 401 { // 토큰 관련 에러일 경우
            Task {
                let refreshCompleted = await refreshAccessToken()
                if refreshCompleted, let newAccessToken = KeyChainManager.readItem(key: "accessToken") {
                    completion(.retry) // 토큰 최신화가 되면 retry
                } else {
                    completion(.doNotRetry)
                }
            }
        } else { // 토큰 관련 에러가 아닐 경우 retry 안 하고 에러 발생
            completion(.doNotRetryWithError(error))
        }
        
    }
    
        // 토큰 리프레시 함수
        private func refreshAccessToken() async -> Bool {
            
            let savedRefreshToken = KeyChainManager.readItem(key: "refreshToken") ?? ""
            guard let refreshTokenResponse = await AuthService.refreshingToken(refreshToken: savedRefreshToken) else {
                return false
            }
    
            // 갱신된 토큰 저장
            if let newAccessToken = refreshTokenResponse.data?.accessToken{
                KeyChainManager.updateItem(key: "accessToken", value: newAccessToken)
                return true
            } else {
                return false
            }
        }
}


enum AuthError: Error {
    case noToken
}

