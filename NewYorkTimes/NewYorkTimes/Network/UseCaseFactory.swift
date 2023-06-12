//
//  UseCaseFactory.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

struct UseCaseFactory {
    static func makeNewsUseCase() -> NewsUseCaseType {
        return NewsUseCase(baseUrl: Constants.baseURL, authProvider: ApiKeyProvider.shared)
    }
}
