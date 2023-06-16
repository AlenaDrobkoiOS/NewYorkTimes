//
//  TextCellModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 16.06.23.
//

import Foundation

enum TextCellModelType {
    case title
    case source
    case content
    case date
    case author
}

struct TextCellModel {
    let text: String?
    let type: TextCellModelType
}
