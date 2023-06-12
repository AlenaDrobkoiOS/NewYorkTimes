//
//  NewsRequestData.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 11.06.23.
//

import Foundation

struct NewsRequestData: Codable {
    let country: String // The 2-letter ISO 3166-1 code of the country you want to get headlines for. Possible options: ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za.
    let category: String // The category you want to get headlines for. Possible options: business entertainment general health science sports technology.
    let pageSize: Int // The number of results to return per page (request). 20 is the default, 100 is the maximum.
    let page: Int // Use this to page through the results if the total results found is greater than the page size.
}
