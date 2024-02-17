//
//  CancelBag.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 29/7/23.
//

import Combine

final class CancelBag {
    var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.forEach{ $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
