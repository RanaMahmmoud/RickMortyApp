//
//  PageInfoModel.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation

struct PageInfoModel: Codable {
    let totalCount: Int
    let totalPages: Int
    let nextPageURL: String?
    let previousPageURL: String?

    enum CodingKeys: String, CodingKey {
        case totalCount = "count"
        case totalPages = "pages"
        case nextPageURL = "next"
        case previousPageURL = "prev"
    }
}
