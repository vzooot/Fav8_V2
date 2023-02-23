//
//  CancelBag.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Combine
import Foundation

final class CancelBag {

    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {

    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
