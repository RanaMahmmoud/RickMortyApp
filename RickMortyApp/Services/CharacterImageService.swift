//
//  CharacterImageService.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import UIKit
import Combine

class CharacterImageService {
    private var cancellables = Set<AnyCancellable>()
    
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
        
        // Download the image
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                try NetworkingManager.handleURLResponse(output: output, url: url)
            }
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
