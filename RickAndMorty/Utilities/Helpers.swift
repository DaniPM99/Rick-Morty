//
//  Helpers.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import SwiftUI
import Combine

// MARK: - General

extension ProcessInfo {
    var isRunningTests: Bool {
        environment["XCTestConigurationFilePath"] != nil
    }
}

// MARK: - View Inpsection helper

internal final class Inspection<V> where V: View {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()
    
    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
