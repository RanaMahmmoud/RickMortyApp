//
//  HomeView.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//
import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var isPresent = false
    
    var body: some View {

            VStack(alignment: .leading) {
                
                Text(CHARACTER)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                CustomCharacterTabView(viewModel: viewModel)
                if(viewModel.isLoading){
                    ProgressView()
                        .padding()
                    Spacer()
                }
                UITableViewWrapper(viewModel: viewModel,isPresent: $isPresent)
                    .onAppear {
                        viewModel.loadCharacters() 
                    }
       
            }.fullScreenCover(isPresented: $isPresent, content: {
                CharacterDetailView(character: viewModel.selectedCharacter, isPresent: $isPresent)
            })
      }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.sizeThatFits)
    }
}
