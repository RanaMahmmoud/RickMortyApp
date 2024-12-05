//
//  MockNetworkingManager.swift
//  RickMortyAppTests
//
//  Created by Rana Mahmoud on 05/12/2024.
//

import Combine
import Foundation
@testable import RickMortyApp


class MockNetworkingManager {
    static var mockResult: Result<CharacterResponseModel, Error>?

    static func download(url: URL) -> AnyPublisher<Data, Error> {
        guard let result = mockResult else {
            return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
        }

        switch result {
        case .success(let characterResponseModel):
            do {
                let data = try JSONEncoder().encode(characterResponseModel) // Encode the CharacterResponseModel to Data
                return Just(data)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: error).eraseToAnyPublisher() // Return error if encoding fails
            }

        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}



