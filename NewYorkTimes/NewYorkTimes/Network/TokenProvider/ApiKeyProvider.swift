//
//  ApiKeyProvider.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

final class ApiKeyProvider: AuthorizationTokenProvider {
    
    static let shared = ApiKeyProvider()
    
    func token() -> String? {
        return "9a45f772dcf141b392dbb034f0cc3c80"//"0c555e089fca42c382288867a649e7a7"
    }
}
