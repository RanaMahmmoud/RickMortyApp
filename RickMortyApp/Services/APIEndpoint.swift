//
//  APIEndpoint.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 18/02/2025.
//

import Foundation

enum APIEndpoint {
    
    case getCharacters(pageSize: Int , page: Int)
    case getCharacterDetails(id: Int)
    case getFilteredCharacters(status: String,pageSize: Int , page: Int)
    
    func url(using config:APIConfiguration) ->String {
        
        switch self {
            
        case .getCharacters(let pageSize, let page):
            return "\(config.baseURL)character/?count=\(pageSize)&page=\(page)"
            
        case .getCharacterDetails(let id):
            return "\(config.baseURL)character/\(id)"
            
        case .getFilteredCharacters(let status,let pageSize ,let page):
            return "\(config.baseURL)character/?count=\(pageSize)&page=\(page)&status=\(status)"
        }
    }
    
  }
    

