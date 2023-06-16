//
//  DetailsCellModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 16.06.23.
//

import Foundation

/// DetailsCell type with data model: image, text and button
enum DetailsCellModel {
    case image(ImageCellModel)
    case text(TextCellModel)
    case button(ButtonCellModel)
}
