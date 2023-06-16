//
//  Constants.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

/// Helps with constant value
struct Constants {
    static var baseURL: URL {
        guard let url = URL(string: "https://newsapi.org/v2") else {
            fatalError("Failed attempt create chingari URL instance \("https://newsapi.org/v2")")
        }
        return url
    }
    
    static let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let outputDateFormat = "MM/dd/yyyy"
    
    static let country = "us"
}
