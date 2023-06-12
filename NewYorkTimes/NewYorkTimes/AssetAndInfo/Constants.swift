//
//  Constants.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

struct Constants {
    static var baseURL: URL {
        guard let url = URL(string: "https://newsapi.org/v2") else {
            fatalError("Failed attempt create chingari URL instance \("https://newsapi.org/v2")")
        }
        return url
    }
}
