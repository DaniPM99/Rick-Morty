//
//  AppState.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import Foundation

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
}

extension AppState {
    struct UserData: Equatable {
        var characters: Loadable<Results> = .notRequested
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var charactersList = CharacterList.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
    lhs.system == rhs.system
}

extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.userData.characters = .loaded(Results.mockedData)
        state.system.isActive = true
        return state
    }
}
