//
//  SystemEventsHandlerTests.swift
//  RickAndMortyTests
//
//  Created by Daniel Parra Martin on 30/7/23.
//

import Foundation


import XCTest
import UIKit
@testable import RickAndMorty

final class SystemEventsHandlerTests: XCTestCase {
    
    var sut: RealSystemEventsHandler!
    
    override func setUp() {
        sut = RealSystemEventsHandler(appState: .init(AppState()))
    }
    
    func test_didBecomeActive() {
        sut.sceneDidBecomeActive()
        var reference = AppState()
        XCTAssertFalse(reference.system.isActive)
        reference.system.isActive = true
        XCTAssertEqual(sut.appState.value, reference)
    }
    
    func test_willResignActive() {
        sut.sceneDidBecomeActive()
        sut.sceneWillResignActive()
        let reference = AppState()
        XCTAssertEqual(sut.appState.value, reference)
    }
}
