//
//  AppEnvironment.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let session = configuredURLSession()
        let webRepository = configuredWebRepository(session: session)
        let interactors = configuredInteractors(appState: appState, webRepository: webRepository)
        let systemEventsHandler = RealSystemEventsHandler(appState: appState)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepository(session: URLSession) -> WebRepositoryContainer {
        let charactersWebRepository = RealCharactersWebRepository(session: session, baseURL: "https://rickandmortyapi.com/api")
        return WebRepositoryContainer(charactersRepository: charactersWebRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              webRepository: WebRepositoryContainer
    ) -> DIContainer.Interactors {
        let charactersInteractor = RealCharactersInteractor(
            webRepository: webRepository.charactersRepository,
            appState: appState)
        return .init(charactersInteractor: charactersInteractor)
    }
}

private extension AppEnvironment {
    struct WebRepositoryContainer {
        let charactersRepository: CharactersWebRepository
    }
}
