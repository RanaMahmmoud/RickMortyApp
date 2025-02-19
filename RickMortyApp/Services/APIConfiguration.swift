//
//  APIConfiguration.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 18/02/2025.
//

import Foundation

protocol APIConfiguration {
    
    var baseURL:String {get}
}

struct ProductionAPIConfiguration:APIConfiguration {
    
    var baseURL = "https://rickandmortyapi.com/api/"

}

struct MockAPIConfiguration:APIConfiguration {
    
    var baseURL = "https://rickandmortyapi.com/api/"

}
