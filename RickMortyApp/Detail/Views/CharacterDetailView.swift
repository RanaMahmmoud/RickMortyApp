//
//  CharacterDetailView.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    
    let character : CharacterModel?
    @Binding var isPresent:Bool
    @State private var isAnimating = false

    var body: some View {

        ZStack {
          
            Color.theme.background.ignoresSafeArea()
            VStack{
                topView
                bottomView
            }
        }
           
        .onAppear {
            withAnimation {
                isAnimating = true
            }
        }
        .padding(.bottom, 40)
    }
}


extension CharacterDetailView {
    
   private var topView: some View {
       
      ScrollView(.vertical){
            ZStack{
                CharacterImageView(imageURL: character?.imageURL ?? "")
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(maxHeight: 250)
                    .shadow(radius: 10)
                    .scaleEffect(isAnimating ? 1 : 0.95) // Animation effect
                    .animation(.spring(response: 0.6, dampingFraction: 0.5), value: isAnimating)
                
                Button(action: {
                    withAnimation {
                        isPresent = false
                    }
                }) {
                    VStack{
                        HStack(alignment: .top){
                            Image(systemName: "arrow.left")
                                .foregroundColor(Color.theme.accent)
                                .padding()
                                .background(Circle().fill(Color.theme.background))
                                .shadow(radius: 4)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .padding(.leading, 16)
                .padding(.top, 16)
            }
        }
    }
    
    private var bottomView: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(character?.name ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        
                     Spacer()

                    Text(character?.status.rawValue ?? "")
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical,6)
                        .background(Capsule().fill(character?.status.backgroundColor ?? .clear))
                        .foregroundColor(Color.theme.accent)
                        .animation(.easeInOut, value: isAnimating)
                }

                HStack {
                    Text("\(character?.species ?? "") • \(character?.gender.rawValue ?? "")")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)

                    Spacer()
                }

                HStack {
                    Text("Location: ")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.accent)

                    Text(character?.currentLocation.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.padding(.vertical,10)
                Spacer()
            }.padding(.horizontal,20)
    }
}


struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: dev.characters[0], isPresent: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
