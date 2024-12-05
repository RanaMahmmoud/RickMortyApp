//
//  CharacterImageView.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI

struct CharacterImageView: View {
    @StateObject private var viewModel: CharacterImageViewModel
    
    init(imageURL: String) {
        _viewModel = StateObject(wrappedValue: CharacterImageViewModel(imageURL: imageURL))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
            } else if viewModel.hasError {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CharacterImageView_Preview : PreviewProvider {
    static var previews: some View {
        CharacterImageView(imageURL: dev.characters[0].imageURL)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

