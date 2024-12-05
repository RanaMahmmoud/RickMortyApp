//
//  LaunchView.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI

struct LaunchView: View {

@State private var isAnimating = false
@State private var showMainView = false

   var body: some View {
       ZStack {
           if showMainView {
               HomeView()
           } else {
               VStack {
                   Image("launch")
                       .resizable()
                       .scaledToFit()
                       .scaleEffect(isAnimating ? 1 : 0.6)
                       .opacity(isAnimating ? 1 : 0.4)
                       .animation(.easeInOut(duration: 1.5), value: isAnimating)
                       
               }.ignoresSafeArea()
               .onAppear {
                   startAnimation()
               }
           }
       }
   }

   private func startAnimation() {
       withAnimation {
           isAnimating = true
       }
       
       DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
           withAnimation {
               showMainView = true
           }
       }
   }
}
#Preview {
    LaunchView()
}
