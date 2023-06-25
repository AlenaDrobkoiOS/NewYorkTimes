//
//  NewsUseCase.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Combine

/// NewsUseCase service protocol
protocol NewsUseCaseType: Service {
    func getTopHeadlines(_ data: NewsRequestData) -> AnyPublisher<NewsResponce, NetworkError>
}

/// NewsUseCase - trigger news requests
final class NewsUseCase: NetworkProvider<NewsEndpoints>, NewsUseCaseType {
    func getTopHeadlines(_ data: NewsRequestData) -> AnyPublisher<NewsResponce, NetworkError> {
        let model = BaseRequestDataModel(sendData: data,
                                         baseUrl: baseUrl,
                                         authorizationToken: authProvider.token())
        return request(endpoint: .topHeadlines(requestData: model))
    }
}
