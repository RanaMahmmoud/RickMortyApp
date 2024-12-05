//
//  CharacterImageViewModel.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI
import Combine

class CharacterImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false

    private let imageService: CharacterImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(imageURL: String, imageService: CharacterImageService = CharacterImageService()) {
        self.imageService = imageService
        fetchImage(from: imageURL)
    }
    
    func fetchImage(from urlString: String) {
        isLoading = true
        imageService.fetchImage(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let image):
                    self?.image = image
                case .failure:
                    self?.hasError = true
                }
            }
        }
    }
}

