//
//  Constants.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation

// MARK: -API Pagination Details
let pageSize = 20

// MARK: -API URL

let baseURL = "https://rickandmortyapi.com/api/"
let getCharactersURL = "\(baseURL)character/?count=\(pageSize)&page="
let getCharactersDetailsURL = "\(baseURL)character/"
let getFilteredCharacters = "\(getCharactersDetailsURL)?status="

// MARK: -Page's Names
let CHARACTER = "Characters"

