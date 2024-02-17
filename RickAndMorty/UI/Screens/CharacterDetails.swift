//
//  CharacterDetails.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 27/7/23.
//

import SwiftUI
import Combine

struct CharacterDetails: View {
    
    let character: Character
    
    @Environment(\.injected) private var injected: DIContainer
    
    init(character: Character) {
        self.character = character
    }
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.yellow, lineWidth: 5))
                        .shadow(color: Color.gray,radius: 5)
                        .padding()
                } placeholder: {
                    ProgressView()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.yellow, lineWidth: 5))
                        .shadow(color: Color.gray,radius: 5)
                        .padding()
                }
                DetailListView(character: character)
            }
        }
    }
}

struct CharacterDetails_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetails(character: Results.mockedData.results[0])
    }
}
