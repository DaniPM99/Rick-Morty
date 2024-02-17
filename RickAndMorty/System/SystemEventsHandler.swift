//
//  SystemEventsHandler.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import UIKit
import Combine

protocol SystemEventsHandler {
    func sceneDidBecomeActive()
    func sceneWillResignActive()
}

struct RealSystemEventsHandler: SystemEventsHandler {
    
    let appState: Store<AppState>
    
    init(appState: Store<AppState>){
        self.appState = appState
    }
    
    func sceneDidBecomeActive() {
        appState[\.system.isActive] = true
    }
    
    func sceneWillResignActive() {
        appState[\.system.isActive] = false
    }
}
