//
//  BaseResponce.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

/// Protocol for responce data
public protocol BaseResponseProtocol: Codable {
    var status: String { get set }
    var code: String? { get set }
    var message: String? { get set }
}

/// Base responce data model - contains info that comes with any responce
struct BaseResponse: BaseResponseProtocol {
    var status: String
    var code: String?
    var message: String?
}
