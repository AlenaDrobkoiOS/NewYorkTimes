//
//  String.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 14.06.23.
//

import Foundation

extension String {
    func getDateString(inputFormat: String = Constants.dateFormat) -> Date? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        return inputFormatter.date(from: self)
    }
}
