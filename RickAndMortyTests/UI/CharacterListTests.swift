//
//  CharacterListTests.swift
//  RickAndMortyUITests
//
//  Created by Daniel Parra Martin on 30/7/23.
//

import XCTest
import ViewInspector
@testable import RickAndMorty

final class CharatersListTests: XCTestCase {

    /*func test_characters_notRequested() {
        let appState = AppState()
        XCTAssertEqual(appState.userData.characters, .notRequested)
        let interactors = DIContainer.Interactors.mocked(
            charactersInteractor: [.loadCharacters]
        )
        let sut = CharacterList()
        let exp = sut.inspection.inspect { view in
            XCTAssertNoThrow(try view.content().text())
            interactors.verify()
        }
        ViewHosting.host(view: sut.inject(appState, interactors))
        wait(for: [exp], timeout: 2)
    }
    
    func test_countries_isLoading_initial() {
        var appState = AppState()
        let interactors = DIContainer.Interactors.mocked()
        appState.userData.characters = .isLoading(last: nil, cancelBag: CancelBag())
        let sut = CharacterList()
        let exp = sut.inspection.inspect { view in
            let vStack = try view.content().vStack()
            XCTAssertNoThrow(try vStack.view(ActivityIndicatorView.self, 0))
            XCTAssertThrowsError(try vStack.list(1))
            interactors.verify()
        }
        ViewHosting.host(view: sut.inject(appState, interactors))
        wait(for: [exp], timeout: 2)
    }
    
    func test_characters_isLoading_refresh() {
        var appState = AppState()
        appState.userData.characters = .isLoading(last: Results.mockedData,
                                                 cancelBag: CancelBag())
        let interactors = DIContainer.Interactors.mocked()
        let sut = CharacterList()
        let exp = sut.inspection.inspect { view in
            let vStack = try view.content().vStack()
            XCTAssertNoThrow(try vStack.view(ActivityIndicatorView.self, 0))
            let countries = try vStack.vStack(1)
            XCTAssertNoThrow(try characters.list(1))
            interactors.verify()
        }
        ViewHosting.host(view: sut.inject(appState, interactors))
        wait(for: [exp], timeout: 2)
    }
    
    func test_characters_loaded() {
        var appState = AppState()
        appState.userData.characters = .loaded(Results.mockedData)
        let interactors = DIContainer.Interactors.mocked()
        let sut = CharacterList()
        let exp = sut.inspection.inspect { view in
            let cell = try view.firstRowLink()
                .label().view(CharacterCell.self).actualView()
            XCTAssertEqual(cell.character, Results.mockedData.results[0])
            interactors.verify()
        }
        ViewHosting.host(view: sut.inject(appState, interactors))
        wait(for: [exp], timeout: 2)
    }
    
    func test_character_failed() {
        var appState = AppState()
        appState.userData.characters = .failed(NSError.test)
        let interactors = DIContainer.Interactors.mocked()
        let sut = CharacterList()
        let exp = sut.inspection.inspect { view in
            XCTAssertNoThrow(try view.content().view(ErrorView.self))
            interactors.verify()
        }
        ViewHosting.host(view: sut.inject(appState, interactors))
        wait(for: [exp], timeout: 2)
    }
    
    func test_character_failed_retry() {
        var appState = AppState()
        appState.userData.characters = .failed(NSError.test)
        let interactors = DIContainer.Interactors.mocked(
            charactersInteractor: [.loadCharacters]
        )
        let container = DIContainer(appState: .init(appState),
                                    interactors: interactors)
        let sut = CharacterList()
        let exp = sut.inspection.inspect { view in
            let errorView = try view.content().view(ErrorView.self)
            try errorView.vStack().button(2).tap()
            interactors.verify()
        }
        ViewHosting.host(view: sut.inject(container))
        wait(for: [exp], timeout: 2)
    }*/
}

// MARK: - CharactersList inspection helper

/*extension InspectableView where View == ViewType.View<CharacterList> {
    func content() throws -> InspectableView<ViewType.AnyView> {
        return try geometryReader().navigationView().anyView(0)
    }
    func firstRowLink() throws -> InspectableView<ViewType.NavigationLink> {
        return try content().vStack().list(1).forEach(0).hStack(0).navigationLink(0)
    }
}*/
