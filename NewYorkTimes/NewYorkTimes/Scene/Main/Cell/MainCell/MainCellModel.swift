//
//  MainCellModel.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import Foundation

public struct MainCellModel {
    let title: String?
    let date: String?
    let imageURL: String?
    
    init(title: String?, date: String?, imageURL: String?) {
        self.title = title
        self.date = date
        self.imageURL = imageURL
    }
    
    init(data: ArticleDataType) {
        self.title = data.title
        self.date = data.publishedAt?.getDate()?.timeAgoDisplay()
        self.imageURL = data.urlToImage
    }
}
