//
//  CharacterImageService.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import UIKit
import Combine

class CharacterImageService {
    private var cancellables : Set<AnyCancellable>
    private let networkService:NetworkingServiceProtocol
    
    init(cancellables: Set<AnyCancellable> = Set<AnyCancellable>(), networkService: NetworkingServiceProtocol = NetworkingManager()) {
        self.cancellables = cancellables
        self.networkService = networkService
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        // Check for cached image
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
           let cachedImage = UIImage(data: cachedResponse.data) {
            completion(.success(cachedImage))
            return
        }
        
        networkService.download(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                NetworkingManager.handleCompletion(completion: completionStatus)
                if case let .failure(error) = completionStatus {
                    completion(.failure(error))
                }
            }, receiveValue: { [weak self] data in
                if let image = UIImage(data: data) {
                    self?.cacheImage(data: data, for: url)
                    completion(.success(image))
                } else {
                    completion(.failure(URLError(.cannotDecodeContentData)))
                }
            })
            .store(in: &cancellables)
       
    }
    
    private func cacheImage(data: Data, for url: URL) {
        let response = URLResponse(url: url, mimeType: "image/png", expectedContentLength: data.count, textEncodingName: nil)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
    }
}
