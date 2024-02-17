//
//  ContentViewTests.swift
//  RickAndMortyUITests
//
//  Created by Daniel Parra Martin on 30/7/23.
//

import XCTest
import ViewInspector
@testable import RickAndMorty

final class ContentViewTests: XCTestCase {
    
    final class ContentViewTests: XCTestCase {
        
        func test_content_for_tests() throws {
            let sut = ContentView(container: .defaultValue, isRunningTests: true)
            XCTAssertNoThrow(try sut.inspect().group().text(0))
        }
        
        func test_content_for_build() throws {
            let sut = ContentView(container: .defaultValue, isRunningTests: false)
            XCTAssertNoThrow(try sut.inspect().group().view(CharacterList.self, 0))
        }
    }
}
