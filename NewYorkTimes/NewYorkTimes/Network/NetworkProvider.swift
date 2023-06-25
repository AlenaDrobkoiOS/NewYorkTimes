//
//  NetworkProvider.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Moya
import Combine

/// Network Provider - use MoyaProvider and trigger request
class NetworkProvider<EndpointType: TargetType> {
    let provider = MoyaProvider<EndpointType>()
    
    let baseUrl: URL
    let authProvider: AuthorizationTokenProvider
    
    init(baseUrl: URL, authProvider: AuthorizationTokenProvider) {
        self.baseUrl = baseUrl
        self.authProvider = authProvider
    }
    
    internal func request<T>(endpoint: EndpointType) -> AnyPublisher<T, NetworkError> where T: BaseResponseProtocol {
        return provider.requestPublisher(endpoint)
            .map(T.self, using: JSONDecoder())
            .mapError { error in
                return NetworkError.serverError(error: error.errorDescription)
            }
            .eraseToAnyPublisher()
    }
}
