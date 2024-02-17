//
//  MockedInteractors.swift
//  RickAndMortyTests
//
//  Created by Daniel Parra Martin on 30/7/23.
//

import XCTest
import SwiftUI
import Combine
@testable import RickAndMorty

extension DIContainer.Interactors {
    static func mocked(
        charactersInteractor: [MockedCharactersInteractor.Action] = []
    ) -> DIContainer.Interactors {
        .init(charactersInteractor: MockedCharactersInteractor(expected: charactersInteractor))
    }
    
    func verify(file: StaticString = #file, line: UInt = #line) {
        (charactersInteractor as? MockedCharactersInteractor)?
            .verify(file: file, line: line)
    }
}

// MARK: - CharactersInteractor

struct MockedCharactersInteractor: Mock, CharactersInteractor {
    
    enum Action: Equatable {
        case loadCharacters
    }
    
    let actions: MockActions<Action>
    
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    func loadCharacters() {
        register(.loadCharacters)
    }
}
