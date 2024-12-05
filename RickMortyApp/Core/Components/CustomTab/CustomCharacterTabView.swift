//
//  CustomCharacterTabView.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI

struct CustomCharacterTabView: View {
    @ObservedObject var viewModel : HomeViewModel
    var body: some View {
        HStack {
            ForEach(CharacterStatus.allCases, id: \.self) { status in
                VStack(spacing:0){
                    Button(action: {
                        withAnimation(.easeInOut) {
                            if(mapToAppStatus(characterStatus: status) ?? .none == viewModel.selectedStatus){
                                viewModel.selectedStatus = .none
                            }else{
                                viewModel.selectedStatus = mapToAppStatus(characterStatus: status) ?? .none
                            }
                            viewModel.filterCharacters()
                        }
                    }) {
                        Text(status.rawValue)
                            
                          
                    }
                    .padding(10)
                .background(viewModel.selectedStatus == mapToAppStatus(characterStatus: status) ?? .none ? Color.theme.red : Color.clear)
                
                .foregroundColor(viewModel.selectedStatus == mapToAppStatus(characterStatus: status) ?? .none ? .white : .black)
              
                
                
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(viewModel.selectedStatus == mapToAppStatus(characterStatus: status) ?? .none ? Color.clear : Color.gray , lineWidth: 0.4)
                       
                )
                .cornerRadius(20)
                   .buttonStyle(PlainButtonStyle())
                    
                }
                
           
                
                   
            }
            Spacer()
        }
        .padding()
        
    }
    
    
    func mapToAppStatus(characterStatus: CharacterStatus) -> AppCharacterStatus? {
        // Check if the raw value exists in AppCharacterStatus enum
        if let appStatus = AppCharacterStatus(rawValue: characterStatus.rawValue) {
            return appStatus
        }
        return nil
    }
}

#Preview {
    CustomCharacterTabView(viewModel: HomeViewModel())
}
