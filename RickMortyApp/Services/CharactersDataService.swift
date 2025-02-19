//
//  CharactersDataService.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation
import Combine

class CharactersDataService {
    private let apiConfig:APIConfiguration
    private let networkingService: NetworkingServiceProtocol

    init(apiCofig: APIConfiguration = ProductionAPIConfiguration() , networkingService:NetworkingServiceProtocol = NetworkingManager()) {
        
        self.apiConfig = apiCofig
        self.networkingService = networkingService
    }
    
    func getCharacters(pageNumber: Int , status: AppCharacterStatus? = nil) -> AnyPublisher<CharacterResponseModel, Error> {
        let endPoint:APIEndpoint = status == nil
        ? .getCharacters(pageSize: pageSize, page: pageNumber)
        : .getFilteredCharacters(status: status?.rawValue ?? "",pageSize: pageSize, page: pageNumber)
        
        guard let url = URL(string: endPoint.url(using: apiConfig)) else {
                 return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
             }
        return networkingService.download(url: url)
                  .decode(type: CharacterResponseModel.self, decoder: JSONDecoder())
                  .eraseToAnyPublisher()
    }

    
   
    
}
