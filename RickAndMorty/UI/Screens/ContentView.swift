//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 27/7/23.
//

import SwiftUI
import Combine
import UIKit

struct ContentView: View {
    
    private let container: DIContainer
    private let isRunningTests: Bool
    
    init(container: DIContainer, isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
        self.container = container
        self.isRunningTests = isRunningTests
    }
    
    var body: some View {
        Group {
            if isRunningTests {
                Text("Test")
            } else {
                CharacterList()
                    .inject(container)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
