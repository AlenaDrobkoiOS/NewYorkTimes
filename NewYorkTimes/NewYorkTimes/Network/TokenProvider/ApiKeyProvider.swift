//
//  ApiKeyProvider.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

/// Api key provider:  return current api key
final class ApiKeyProvider: AuthorizationTokenProvider {
    
    static let shared = ApiKeyProvider()
    
    func token() -> String? {
        return "9a45f772dcf141b392dbb034f0cc3c80"
    }
}
