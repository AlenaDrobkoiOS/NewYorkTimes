//
//  BaseResponce.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

public protocol BaseResponseProtocol: Codable {
    var status: String { get set }
    var code: String? { get set }
    var message: String? { get set }
}

struct BaseResponse: BaseResponseProtocol {
    var status: String
    var code: String?
    var message: String?
}
