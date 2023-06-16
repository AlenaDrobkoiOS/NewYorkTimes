//
//  Style.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 14.06.23.
//

import UIKit

struct Style {
    
    enum Images: String {
        case placeholder
        case menu
        case general
        case business
        case entertainment
        case health
        case science
        case sports
        case technology
        
        var imageName: String {
            switch self {
            case .placeholder:
                return "newspaper_placeholder"
            case .menu:
                return "list.dash"
            case .general:
                return "newspaper"
            case .business:
                return "briefcase"
            case .entertainment:
                return "film"
            case .health:
                return "stethoscope"
            case .science:
                return "bolt"
            case .sports:
                return "sportscourt"
            case .technology:
                return "desktopcomputer"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .placeholder:
                return UIImage(named: self.imageName)
            case .menu, .general, .business, .entertainment, .health, .science, .sports, .technology:
                return UIImage(systemName: self.imageName)
            }
        }
    }
    
    struct Font {
        static let semiboldText = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let boldText = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let regularMidleText = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let mediumText = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let regularSmallText = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}
