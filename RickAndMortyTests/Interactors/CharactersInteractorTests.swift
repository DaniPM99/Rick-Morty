//
//  CharactersInteractorTests.swift
//  RickAndMortyTests
//
//  Created by Daniel Parra Martin on 30/7/23.
//

import XCTest
import SwiftUI
import Combine
@testable import RickAndMorty

final class CharactersInteractorTests: XCTestCase {

    let appState = CurrentValueSubject<AppState, Never>(AppState())
    var mockedRepository: MockedCharactersWebRepository!
    var sut: RealCharactersInteractor!
    var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        appState.value = AppState()
        mockedRepository = MockedCharactersWebRepository()
        sut = RealCharactersInteractor(webRepository: mockedRepository, appState: appState)
        subscriptions = Set<AnyCancellable>()
    }
    
    // MARK: - loadCharacters
    
    func test_loadCharacters_notRequested_to_loaded() {
        let characters = Results.mockedData.results
        mockedRepository.charactersResponse = .success(Results(results: characters))
        mockedRepository.actions = .init(expected: [
            .loadCharacters
        ])
        let updates = recordAppStateUserDataUpdates()
        sut.loadCharacters()
        let exp = XCTestExpectation(description: "Completion")
        updates.sink { updates in
            XCTAssertEqual(updates, [
                AppState.UserData(characters: .notRequested),
                AppState.UserData(characters: .isLoading(last: nil, cancelBag: CancelBag())),
                AppState.UserData(characters: .loaded(Results(results:characters)))
            ])
            self.mockedRepository.verify()
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_loadCharacters_loaded_to_loaded() {
        let initialCharacters = Results.mockedData.results
        let finalCharacters = [initialCharacters[0], initialCharacters[1]]
        appState[\.userData.characters] = .loaded(Results(results:initialCharacters))
        mockedRepository.charactersResponse = .success(Results(results: finalCharacters))
        mockedRepository.actions = .init(expected: [
            .loadCharacters
        ])
        let updates = recordAppStateUserDataUpdates()
        sut.loadCharacters()
        let exp = XCTestExpectation(description: "Completion")
        updates.sink { updates in
            XCTAssertEqual(updates, [
                AppState.UserData(characters: .loaded(Results(results:initialCharacters))),
                AppState.UserData(characters: .isLoading(last: Results(results:initialCharacters),
                                                        cancelBag: CancelBag())),
                AppState.UserData(characters: .loaded(Results(results:finalCharacters)))
            ])
            self.mockedRepository.verify()
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_loadCharacters_notRequested_to_failed() {
        let error = NSError.test
        mockedRepository.charactersResponse = .failure(error)
        mockedRepository.actions = .init(expected: [
            .loadCharacters
        ])
        let updates = recordAppStateUserDataUpdates()
        sut.loadCharacters()
        let exp = XCTestExpectation(description: "Completion")
        updates.sink { updates in
            XCTAssertEqual(updates, [
                AppState.UserData(characters: .notRequested),
                AppState.UserData(characters: .isLoading(last: nil, cancelBag: CancelBag())),
                AppState.UserData(characters: .failed(error))
            ])
            self.mockedRepository.verify()
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    
    // MARK: - Helper
    
    private func recordAppStateUserDataUpdates(for timeInterval: TimeInterval = 0.5)
        -> AnyPublisher<[AppState.UserData], Never> {
        return Future<[AppState.UserData], Never> { (completion) in
            var updates = [AppState.UserData]()
            self.appState.map(\.userData)
                .sink { updates.append($0 )}
                .store(in: &self.subscriptions)
            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
                completion(.success(updates))
            }
        }.eraseToAnyPublisher()
    }
}
