//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 27/7/23.
//

import SwiftUI

struct CharacterCell: View {
    
    var character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { image in
                ImageView(image: image)
            } placeholder: {
                ProgressView()
                    .frame(width: UIScreen.main.bounds.width, height: 400)
            }
            CharacterNameRow(character: character)
        }
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: Results.mockedData.results[0])
    }
}
