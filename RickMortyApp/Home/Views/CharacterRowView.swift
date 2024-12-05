//
//  CharacterRowView.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI

struct CharacterRowView: View {
    let character : CharacterModel
    
    var body: some View {
    HStack(spacing: 0) {
        leftColumn
        Spacer()
        
    }
    .font(.subheadline)
    .background(
        Color.theme.background.opacity(0.001)
    )
    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//    .onTapGesture {
// 
//        print(character.name)
//    }
    .listRowBackground(Color.theme.background)
    .padding(5)
    .background(Color.white)
    .cornerRadius(10)
   
    .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.theme.lighGray , lineWidth: 0.5)
    )
    .padding(.horizontal,20)
    .padding(.vertical,10)
    }
}


extension CharacterRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            CharacterImageView(imageURL: character.imageURL)
                .frame(width: 90, height: 90)
            titlesColumn
        }.padding(10)
            .fixedSize()
    }
    private var titlesColumn: some View {
      
        VStack(alignment: .leading){
                Text(character.name)
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: 200, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
            
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(Color.theme.secondaryText)
                    .frame(maxWidth: 200, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                
                Spacer()
            }.padding(.leading, 15)
       
    }
}


struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: dev.characters[0])
            .previewLayout(.sizeThatFits)
            
    }
}
