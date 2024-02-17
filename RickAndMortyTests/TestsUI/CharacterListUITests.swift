//
//  CharacterListUITests.swift
//  RickAndMortyTests
//
//  Created by Daniel Parra Martin on 12/12/23.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import RickAndMorty

extension CharacterList: Inspectable { }
extension ActivityIndicatorView: Inspectable { }
extension CharacterCell: Inspectable { }
extension ErrorView: Inspectable { }

final class CharacterListUITests: XCTestCase {
    
    func test_characters_notRequested() {
        let appState = AppState()
        XCTAssertEqual(appState.userData.characters, .notRequested)
        let interactors = DIContainer.Interactors.mocked(
            charactersInteractor: [.loadCharacters]
        )
        let sut = CharacterList()
        ViewHosting.host(view: sut.inject(appState, interactors))
    }
    func test_characters_isLoading_initial() {
        var appState = AppState()
        let interactors = DIContainer.Interactors.mocked()
        appState.userData.characters = .isLoading(last: nil, cancelBag: CancelBag())
        let sut = CharacterList()
        ViewHosting.host(view: sut.inject(appState, interactors))
    }
    
    func test_characters_isLoading_refresh() {
        var appState = AppState()
        appState.userData.characters = .isLoading(last: Results.mockedData,
                                                 cancelBag: CancelBag())
        let interactors = DIContainer.Interactors.mocked()
        let sut = CharacterList()
        ViewHosting.host(view: sut.inject(appState, interactors))
    }
    
    func test_characters_loaded() {
        var appState = AppState()
        appState.userData.characters = .loaded(Results.mockedData)
        let interactors = DIContainer.Interactors.mocked()
        let sut = CharacterList()
        ViewHosting.host(view: sut.inject(appState, interactors))
    }
    
    func test_characters_failed() {
        var appState = AppState()
        appState.userData.characters = .failed(NSError.test)
        let interactors = DIContainer.Interactors.mocked()
        let sut = CharacterList()
        ViewHosting.host(view: sut.inject(appState, interactors))
    }
    
    func test_characters_failed_retry() {
        var appState = AppState()
        appState.userData.characters = .failed(NSError.test)
        let interactors = DIContainer.Interactors.mocked(
            charactersInteractor: [.loadCharacters]
        )
        let container = DIContainer(appState: .init(appState),
                                    interactors: interactors)
        let sut = CharacterList()
        ViewHosting.host(view: sut.inject(container))
    }
}

// MARK: - CountriesList inspection helper

extension InspectableView where View == ViewType.View<CharacterList> {
    func content() throws -> InspectableView<ViewType.AnyView> {
        return try geometryReader().navigationView().anyView(0)
    }
}
