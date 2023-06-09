//
//  Localizationable.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 14.06.23.
//

import Foundation

protocol LocalizableDelegate {
    var rawValue: String { get } //localize key
    var localized: String { get }
}

extension LocalizableDelegate {
    ///returns a localized value by specified key located in the specified table
    var localized: String {
        return rawValue.localized
    }
}

/// Helps with localization
enum Localizationable {
    enum Global: String, LocalizableDelegate {
        case menuTitle = "Global.menuTitle"
        case error = "Global.error"
        case warning = "Global.warning"
        case ok = "Global.OK"
        case openInfo = "Global.openInfo"
        case urlWarning = "Global.urlWarning"
        case noElementsWarning = "Global.noElementsWarning"
        case countWarning = "Global.countWarning"
        case unknownError = "Global.unknownError"
    }
}
