//
//  LocationModel.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 05/12/2024.
//

import Foundation

struct LocationModel: Codable,Identifiable {
    let id = UUID()
    let name: String
    let url: String
}
