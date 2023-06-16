//
//  NewsCategory.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import Foundation

/// News category: general, business, entertainment, health, science, sports, technology
enum NewsCategory: String, CaseIterable, Codable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var image: Style.Images? {
        return Style.Images(rawValue: self.rawValue)
    }
}
