//
//  ApiKeyProvider.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

public protocol AuthorizationTokenProvider {
    func token() -> String?
}

final class ApiKeyProvider: AuthorizationTokenProvider {
    
    static let shared = ApiKeyProvider()
    
    func token() -> String? {
        return "0c555e089fca42c382288867a649e7a7"
    }
}
