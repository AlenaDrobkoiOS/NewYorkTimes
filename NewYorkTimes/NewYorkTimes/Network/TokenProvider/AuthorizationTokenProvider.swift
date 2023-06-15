//
//  AuthorizationTokenProvider.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import Foundation

public protocol AuthorizationTokenProvider {
    func token() -> String?
}
