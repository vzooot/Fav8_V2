//
//  Loadable.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Foundation

enum Loadable<Success, Failure: Error> {
    typealias LoadableResult = Result<Success, Failure>
    case notRequested
    case isLoading(previous: LoadableResult?, cancelBag: CancelBag)
    case loaded(LoadableResult)

    var result: Result<Success, Failure>? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last, _): return last
        default: return nil
        }
    }

    var error: Failure? {
        get {
            switch result {
            case let .failure(error): return error
            default: return nil
            }
        }
        set {
            if let newValue = newValue {
                self = .loaded(.failure(newValue))
            } else {
                self = .notRequested
            }
        }
    }
}

extension Loadable {
    mutating func setIsLoading(cancelBag: CancelBag) {
        self = .isLoading(previous: result, cancelBag: cancelBag)
    }
}

extension Loadable: Equatable where Success: Equatable, Failure: Equatable {
    static func == (lhs: Loadable<Success, Failure>, rhs: Loadable<Success, Failure>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested): return true
        case let (.isLoading(lhsV, _), .isLoading(rhsV, _)): return lhsV == rhsV
        case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
        default: return false
        }
    }
}
