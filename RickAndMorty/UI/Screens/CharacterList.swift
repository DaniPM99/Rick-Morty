//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 27/7/23.
//

import SwiftUI
import UIKit
import Combine

struct CharacterList: View {
    
    @Environment(\.injected) private var injected: DIContainer
    let inspection = Inspection<Self>()
    @State private var allCharacters = AllCharacters()
    @State private var searchText = ""
    @State private var searched = false
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.charactersList)
    }
    @State private var actualPage = 1
    
    var body: some View {

        NavigationStack{
            ZStack {
                BackgroundView()
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false){
                        self.content
                            .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / 5), axis: (x: 0.0, y: -10.0, z: 0.0))
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 500)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a name")
        .onSubmit(of: .search, loadCharactersByName)
        .modifier(NavigationViewStyle())
        .onReceive(charactersUpdate) { self.allCharacters.all = $0}
        .onReceive(routingUpdate) { self.routingState = $0}
        .onReceive(inspection.notice) { self.inspection.visit(self, $0)}
    }
    
    private var content: AnyView {
        switch allCharacters.filtered {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(last , _): return AnyView(loadingView(last))
        case let .loaded(characters): return AnyView(loadedView(characters))
        case let .failed(error): return AnyView(failedView(error))
        }
    }
}

private extension CharacterList {
    struct NavigationViewStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
        }
    }
}

// MARK: - Side Effects

private extension CharacterList {
    func loadCharacters() {
        injected.interactors.charactersInteractor.loadCharacters(page: actualPage)
    }
    func loadCharactersByName() {
        searched = true
        injected.interactors.charactersInteractor.loadCharacters(name: searchText)
        searchText = ""
    }
}

// MARK: - Loading Content

private extension CharacterList {
    var notRequestedView: some View {
        Text("").onAppear(){
            self.loadCharacters()
        }
    }
    
    func loadingView(_ previouslyLoaded: Results?) -> some View {
        VStack {
            ActivityIndicatorView().padding()
            previouslyLoaded.map {
                loadedView($0)
            }
        }
        .frame(width: 300, height: 300, alignment: .center)
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            self.loadCharacters()
        })
        .frame(width: 300, height: 300, alignment: .center)
    }
}

// MARK: - DisplayingContent

private extension CharacterList {
    func loadedView(_ results: Results) -> some View {
        HStack(spacing: 20) {
            if actualPage > 1 && !searched {
                SwapPageView(image: UIImage(named: "BackImage")!, text: "Previous page")
                    .onTapGesture(perform: {
                        actualPage = actualPage - 1
                        loadCharacters()
                    })
            } else if searched {
                SwapPageView(image: UIImage(named: "BackImage")!, text: "Back to all Characters")
                    .onTapGesture(perform: {
                        searched = false
                        actualPage = 1
                        loadCharacters()
                    })
            }
            ForEach(results.results){ character in
                NavigationLink(destination: detailsView(character: character)){
                    CharacterCell(character: character)
                }
                .isDetailLink(false)
            }
            if actualPage <= 42 && !searched {
                SwapPageView(image: UIImage(named: "NextImage")!, text: "Next page")
                    .onTapGesture(perform: {
                        actualPage = actualPage + 1
                        loadCharacters()
                    })
            }
        }.padding(.vertical, 24)
    }
    
    func detailsView(character: Character) -> some View {
        CharacterDetails(character: character)
    }
}

// MARK: - Characters

extension CharacterList {
    struct AllCharacters {
        
        private(set) var filtered: Loadable<Results> = .notRequested
        var all: Loadable<Results> = .notRequested {
            didSet { filterCharacters() }
        }
        var locale = Locale.current
        
        private mutating func filterCharacters() {
            filtered = all
        }
    }
}

// MARK: - Routing

extension CharacterList {
    struct Routing: Equatable {
        var characterDetails: Character.Code?
    }
}

// MARK: - State Updates

private extension CharacterList {
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.charactersList)
    }
    
    var charactersUpdate: AnyPublisher<Loadable<Results>, Never> {
        injected.appState.updates(for: \.userData.characters)
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList().inject(.preview)
    }
}
