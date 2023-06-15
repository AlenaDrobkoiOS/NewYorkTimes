//
//  Date.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 14.06.23.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
