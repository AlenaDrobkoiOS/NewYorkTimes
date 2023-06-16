//
//  String.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 14.06.23.
//

import Foundation

extension String {
    func getDate(inputFormat: String = Constants.inputDateFormat) -> Date? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        return inputFormatter.date(from: self)
    }
    
    func getDateString(inputFormat: String = Constants.inputDateFormat,
                       outputFormat: String = Constants.outputDateFormat) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.timeZone = TimeZone.current
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: date)
    }
}
