//
//  CharacterModel.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation
import SwiftUI

struct CharacterModel: Identifiable, Codable ,Equatable {
    
    static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        return lhs.id == rhs.id
    }

    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let imageURL: String
    let origin: LocationModel
    let currentLocation: LocationModel
    let episodeURLs: [String]
    let detailsURL: String
    let creationDate: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case currentLocation = "location"
        case imageURL = "image"
        case episodeURLs = "episode"
        case detailsURL = "url"
        case creationDate = "created"
    }

}

enum CharacterStatus: String, Codable ,CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    /// A computed property that returns the corresponding background color for each status
    var backgroundColor: Color {
        switch self {
        case .alive:
            return Color.green.opacity(0.2) // Light green for "Alive"
        case .dead:
            return Color.red.opacity(0.2)   // Light red for "Dead"
        case .unknown:
            return Color.gray.opacity(0.2)  // Light gray for "Unknown"
        }
    }
}

enum CharacterGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}

enum AppCharacterStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    case none // "None" case for UI filtering
}
