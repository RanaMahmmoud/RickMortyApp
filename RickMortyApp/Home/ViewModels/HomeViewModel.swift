//
//  HomeViewModel.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var totalCount = 1
    @Published var characters: [CharacterModel] = []
    @Published var selectedCharacter: CharacterModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasMoreData = true
    @Published var filteredCharacters: [CharacterModel] = []
    @Published var selectedStatus: AppCharacterStatus = .none
    
    private var isFilter:Bool = false
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var charactersDataService: CharactersDataService
        
    init(service: CharactersDataService = CharactersDataService()) {
            self.charactersDataService = service
            loadCharacters()
    }
 
    func loadCharacters() {
        guard !isLoading && hasMoreData else { return }

         isLoading = true
         errorMessage = nil

         charactersDataService
            .getCharacters(pageNumber: currentPage , status: selectedStatus != .none ? selectedStatus : nil)
             .sink(receiveCompletion: { [weak self] (completion: Subscribers.Completion<Error>) in
                 DispatchQueue.main.async {
                     self?.isLoading = false
                     switch completion {
                     case .failure(let error):
                         self?.errorMessage = error.localizedDescription
                     case .finished:
                         break
                     }
                 }
             }, receiveValue: { [weak self] response in
                 DispatchQueue.main.async {
                     self?.totalCount = response.pageInfo.totalCount
                     
                     if (!response.characters.isEmpty && (self?.isFilter == false)) {
                         self?.hasMoreData = !response.characters.isEmpty
                         self?.characters.append(contentsOf: response.characters)
                         self?.currentPage += 1
                     }else{
                         self?.isFilter = false
                         self?.characters = response.characters
                     }
                 }
             })
             .store(in: &cancellables)
            
       }
       
       func loadMoreCharacters() {
           if(totalCount > characters.count){
               loadCharacters()
           }
       }
    
      func filterCharacters() {
          self.isFilter = true
          self.isLoading = false
          self.hasMoreData = true
          loadCharacters()
      }
   }
   
