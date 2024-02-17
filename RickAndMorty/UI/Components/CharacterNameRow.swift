//
//  CharacterNameRow.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 27/7/23.
//

import SwiftUI

struct CharacterNameRow: View {
    
    let character: Character
    
    
    var body: some View {
        ZStack{
            Text("")
                .frame(width: UIScreen.main.bounds.width, height: 75)
                .background(Color.gray)
            Text(character.name)
                .foregroundColor(Color.black)
        }
        .offset(CGSize(width: 0, height: -82))
        .opacity(0.7)
    }
}

struct CharacterNameRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterNameRow(character: Results.mockedData.results[0])
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 75))
    }
}
