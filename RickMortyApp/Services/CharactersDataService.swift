//
//  CharactersDataService.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation
import Combine

class CharactersDataService {
    
    func getCharacters(pageNumber: Int , status: AppCharacterStatus? = nil) -> AnyPublisher<CharacterResponseModel, Error> {
        var urlString = "\(getCharactersURL)\(pageNumber)"
                if let status = status {
            urlString += "&status=\(status.rawValue)"
        }
        guard let url = URL(string: urlString) else {
                 return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
             }
        return NetworkingManager.download(url: url)
                  .decode(type: CharacterResponseModel.self, decoder: JSONDecoder())
                  .eraseToAnyPublisher()
    }

    
   
    
}
