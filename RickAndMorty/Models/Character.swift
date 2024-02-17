//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 27/7/23.
//

import Foundation

struct Results: Codable, Equatable {
    let results: [Character]
    let info: Information
    
    init(results: [Character], info: Information) {
        self.results = results
        self.info = info
    }
}

struct Information: Codable, Equatable {
    let pages: Int
}

struct Character: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    
    typealias Code = String
    
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Origin, location: Location, image: String ,episode: [String]) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
    }
}

struct Origin : Codable, Equatable{
    var name: String
    var url: String
}

struct Location: Codable, Equatable {
    var name: String
    var url: String
}
