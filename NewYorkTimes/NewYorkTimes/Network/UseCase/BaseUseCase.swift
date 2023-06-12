//
//  BaseUseCase.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

open class BaseUseCase<EndpointType: BaseEndpointType> {
    // MARK: - Internal Properties

    var networkProvider: NetworkProvider

    var tokenProvider: AuthorizationTokenProvider?

    var baseURL: URL

    // MARK: - Constructor

    public init(baseURL: URL) {
        self.baseURL = baseURL
        self.networkProvider = .init()
    }
}
