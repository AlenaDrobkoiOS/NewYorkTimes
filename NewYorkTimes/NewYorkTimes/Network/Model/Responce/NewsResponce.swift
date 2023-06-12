//
//  NewsResponce.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

struct NewsResponce: BaseResponseProtocol {
    var status: String // If the request was successful or not. Options: ok, error. In the case of ok, the below two properties will not be present.
    var code: String? // A short code identifying the type of error returned.
    var message: String? // A fuller description of the error, usually including how to fix it.
    
    var totalResults: Int? // The total number of results available for your request.
    var articles: [ArticleDataType]? // The results of the request.
}

struct ArticleDataType: Codable {
    var source: SourceDataType // The source this article came from.
    var author: String // The author of the article
    var title: String // The headline or title of the article.
    var description: String? // A description or snippet from the article.
    var url: String // The direct URL to the article.
    var urlToImage: String? // The URL to a relevant image for the article.
    var publishedAt: String // The date and time that the article was published, in UTC (+000)
    var content: String? // The unformatted content of the article, where available. This is truncated to 200 chars.
}

struct SourceDataType: Codable {
    var id: String // The identifier of the news source. You can use this with our other endpoints.
    var name: String // The name of the news source
    var description: String? // A description of the news source
    var url: String? // The URL of the homepage.
    var category: String? // The type of news to expect from this news source.
    var language: String? // The language that this news source writes in.
    var country: String? // The country this news source is based in (and primarily writes about).
}
