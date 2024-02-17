//
//  CharactersWebRepositoryTest.swift
//  RickAndMortyTests
//
//  Created by Daniel Parra Martin on 30/7/23.
//

import XCTest
import Combine
@testable import RickAndMorty

final class CharactersWebRepositoryTests: XCTestCase {
    
    private var sut: RealCharactersWebRepository!
    private var subscriptions = Set<AnyCancellable>()
    
    typealias API = RealCharactersWebRepository.API
    typealias Mock = RequestMocking.MockedResponse

    override func setUp() {
        subscriptions = Set<AnyCancellable>()
        sut = RealCharactersWebRepository(session: .mockedResponsesOnly,
                                         baseURL: "https://test.com")
    }

    override func tearDown() {
        RequestMocking.removeAllMocks()
    }
    
    // MARK: - All Characters

    func test_allCharacters() throws {
        let data = Results.mockedData
        try mock(.allCharacters, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.loadCharacters().sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    

    
    // MARK: - Helper
    
    private func mock<T>(_ apiCall: API, result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(apiCall: apiCall, baseURL: sut.baseURL, result: result, httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}
