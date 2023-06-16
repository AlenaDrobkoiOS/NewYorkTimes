//
//  AuthorizationTokenProvider.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import Foundation

/// Protocol for any token, api key or another auth kind provider
public protocol AuthorizationTokenProvider {
    func token() -> String?
}
