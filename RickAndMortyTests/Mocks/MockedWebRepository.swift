//
//  MockedWebRepository.swift
//  RickAndMortyTests
//
//  Created by Daniel Parra Martin on 30/7/23.
//

import XCTest
import Combine
@testable import RickAndMorty

class TestWebRepository: WebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    let bgQueue = DispatchQueue(label: "test")
}

// MARK: - CharactersWebRepository

final class MockedCharactersWebRepository: TestWebRepository, Mock, CharactersWebRepository {
    
    enum Action: Equatable {
        case loadCharacters
    }
    var actions = MockActions<Action>(expected: [])
    
    var charactersResponse: Result<Results, Error> = .failure(MockError.valueNotSet)
    
    func loadCharacters() -> AnyPublisher<Results, Error> {
        register(.loadCharacters)
        return charactersResponse.publish()
    }
}
