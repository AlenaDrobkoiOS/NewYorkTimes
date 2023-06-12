//
//  NewsUseCase.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import RxSwift

protocol NewsUseCaseType: Service {
    func getTopHeadlines(_ data: NewsRequestData) -> Single<NewsResponce>
}

final class NewsUseCase: NetworkProvider<NewsEndpoints>, NewsUseCaseType {
    func getTopHeadlines(_ data: NewsRequestData) -> Single<NewsResponce> {
        let model = BaseRequestDataModel(sendData: data,
                                         baseUrl: baseUrl,
                                         authorizationToken: authProvider.token())
        return request(endpoint: .topHeadlines(requestData: model))
    }
}
