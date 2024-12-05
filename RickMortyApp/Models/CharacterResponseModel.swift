//
//  CharacterResponseModel.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation

struct CharacterResponseModel : Codable {
    let pageInfo: PageInfoModel
    let characters: [CharacterModel]

    enum CodingKeys: String, CodingKey {
        case pageInfo = "info"
        case characters = "results"
    }
}
