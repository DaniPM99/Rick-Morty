//
//  ContentViewUITests.swift
//  RickAndMortyTests
//
//  Created by Daniel Parra Martin on 12/12/23.
//

import XCTest
import ViewInspector
@testable import RickAndMorty

extension ContentView: Inspectable { }

final class ContentViewUITests: XCTestCase {


    func test_content_for_tests() throws {
        let sut = ContentView(container: .defaultValue, isRunningTests: true)
        XCTAssertNoThrow(try sut.inspect().group().text(0))
    }
    
    func test_content_for_build() throws {
        let sut = ContentView(container: .defaultValue, isRunningTests: false)
        XCTAssertNoThrow(try sut.inspect().group().view(CharacterList.self, 0))
    }
    
    func test_change_handler_for_colorScheme() throws {
        var appState = AppState()
        appState.routing.charactersList = .init()
        let container = DIContainer(appState: .init(appState), interactors: .mocked())
        let sut = ContentView(container: container)
        XCTAssertEqual(container.appState.value, appState)
        container.interactors.verify()
    }
    
    func test_change_handler_for_sizeCategory() throws {
        var appState = AppState()
        appState.routing.charactersList = .init()
        let container = DIContainer(appState: .init(appState), interactors: .mocked())
        let sut = ContentView(container: container)
        XCTAssertEqual(container.appState.value, appState)
        XCTAssertEqual(container.appState.value, AppState())
        container.interactors.verify()
    }
}
