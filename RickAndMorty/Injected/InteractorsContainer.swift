//
//  InteractorsContainer.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import Foundation

extension DIContainer {
    struct Interactors {
        let charactersInteractor: CharactersInteractor
        
        init(charactersInteractor: CharactersInteractor){
            self.charactersInteractor = charactersInteractor
        }
        
        static var stub: Self {
            .init(charactersInteractor: StubCharactersInteractor())
        }
    }
    
}
