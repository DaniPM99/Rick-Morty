//
//  CharactersWebRepository.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import Foundation
import Combine
import SwiftUI

protocol CharactersWebRepository: WebRepository {
    func loadCharacters(page: Int) -> AnyPublisher<Results, Error>
    func loadCharacters(name: String) -> AnyPublisher<Results, Error>
}

struct RealCharactersWebRepository: CharactersWebRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String){
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadCharacters(page: Int) -> AnyPublisher<Results, Error> {
        return call(endpoint: API.allCharacters, page: page)
    }
    
    func loadCharacters(name: String) -> AnyPublisher<Results, Error> {
        return call(endpoint: API.filter, name: name)
    }
}


// MARK: - Endpoints

extension RealCharactersWebRepository {
    enum API {
        case allCharacters
        case filter
    }
}

extension RealCharactersWebRepository.API: APICall {
    
    var path: String {
        switch self {
        case .allCharacters:
            return "/character/?page="
        case .filter:
            return "/character/?name="
        }
    }
    
    var method: String {
        switch self {
        case .allCharacters, .filter:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
