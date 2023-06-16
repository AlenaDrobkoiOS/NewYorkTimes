//
//  NewsEndpoints.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Moya

/// News requests enpoints
enum NewsEndpoints: TargetType {
    case topHeadlines(requestData: RequestModelTypeProtocol)

    private var extractedRequestData: RequestModelTypeProtocol {
        switch self {
        case .topHeadlines(let requestData):
            return requestData
        }
    }
}

extension NewsEndpoints{
    var baseURL: URL {
        extractedRequestData.baseUrl
    }

    var path: String {
        switch self {
        case .topHeadlines:
            return "top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topHeadlines:
            return .get
        }
    }
    
    var task: Task {
        guard var parameters = extractedRequestData.parameters else {
            return .requestPlain
        }
        
        parameters["apiKey"] = extractedRequestData.authorizationToken
        
        switch self {
        case .topHeadlines:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
