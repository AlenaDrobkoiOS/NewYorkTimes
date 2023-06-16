//
//  TextCellModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 16.06.23.
//

import Foundation

/// Details screen text cell types: title, source, content, date, author
enum TextCellModelType {
    case title
    case source
    case content
    case date
    case author
}

/// Details screen text cell data model
struct TextCellModel {
    let text: String?
    let type: TextCellModelType
}
