//
//  CharactersInteractor.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import Foundation
import Combine
import SwiftUI

protocol CharactersInteractor {
    func loadCharacters(page: Int)
    func loadCharacters(name: String)
}

struct RealCharactersInteractor: CharactersInteractor {
    let webRepository: CharactersWebRepository
    let appState: Store<AppState>
    
    init(webRepository: CharactersWebRepository, appState: Store<AppState>){
        self.webRepository = webRepository
        self.appState = appState
    }
    
    func loadCharacters(page: Int) {
        let cancelBag = CancelBag()
        appState[\.userData.characters].setIsLoading(cancelBag: cancelBag)
        weak var weakAppState = appState
        webRepository.loadCharacters(page: page)
            .sinkToLoadable { weakAppState?[\.userData.characters] = $0 }
            .store(in: cancelBag)
    }
    
    func loadCharacters(name: String) {
        let cancelBag = CancelBag()
        appState[\.userData.characters].setIsLoading(cancelBag: cancelBag)
        weak var weakAppState = appState
        webRepository.loadCharacters(name: name)
            .sinkToLoadable { weakAppState?[\.userData.characters] = $0 }
            .store(in: cancelBag)
    }

    
}

struct StubCharactersInteractor: CharactersInteractor {
    func loadCharacters(page: Int){
    }
    func loadCharacters(name: String){
        
    }
}
