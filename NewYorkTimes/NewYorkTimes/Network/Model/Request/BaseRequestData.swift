//
//  BaseRequestDataModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

public protocol RequestModelTypeProtocol {
    var baseUrl: URL { get }
    var authorizationToken: String? { get }
    var parameters: [String: Any]? { get }
    var pathEnding: String? { get }
    var customHeaderParameters: [String: String?]? { get }
}

// MARK: - RequestTypeObject extension

public extension RequestModelTypeProtocol {
    var authorizationToken: String? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var pathEnding: Data? {
        return nil
    }
    
    var customHeaderParameters: [String: String?]? {
        return nil
    }
}

struct BaseRequestDataModel<SendData: Encodable>: RequestModelTypeProtocol {
    // MARK: - Properties
    
    public var authorizationToken: String?
    public let baseUrl: URL
    public let pathEnding: String?
    public let customeHeaderParameters: [String: String?]?
    public var parameters: [String: Any]? {
        return sendData.asDictionary()
    }
    
    private let sendData: SendData
    
    // MARK: - Constructor
    
    public init(sendData: SendData,
                baseUrl: URL,
                authorizationToken: String? = nil,
                pathEnding: String? = nil,
                customeHeaderParameters: [String: String?]? = nil) {
        self.sendData = sendData
        self.authorizationToken = authorizationToken
        self.baseUrl = baseUrl
        self.pathEnding = pathEnding
        self.customeHeaderParameters = customeHeaderParameters
    }
}
