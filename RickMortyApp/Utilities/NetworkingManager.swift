//
//  NetworkingManager.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation
import Combine



protocol NetworkingServiceProtocol {
    
    func download(url:URL)->AnyPublisher<Data,Error>
}

class NetworkingManager :NetworkingServiceProtocol{
    
    private let session :URLSession
    
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
 
     func download(url: URL ) -> AnyPublisher<Data, Error> {
        
        return 
        session.dataTaskPublisher(for: url)
             .tryMap({ try self.handleURLResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
     func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
            
            
        }
        
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}

enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
        case .unknown: return "[⚠️] Unknown error occured"
        }
    }
}
