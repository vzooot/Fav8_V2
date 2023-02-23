//
//  ErrorMapperSpy.swift
//  Fav8Tests
//
//  Created by Administrator on 12/6/22.
//

import Foundation

@testable import Fav8

struct ErrorMapperSpy: Spy, RepositoryErrorMapper {
    enum Action {
        case map(Error)
    }

    var actions: SpyActions<Action>

    let resolvedError: RepositoryError

    init(
        _ actions: SpyActions<Action> = .init(expected: []),
        resolvedError: RepositoryError = .unexpected(
            .init(code: -42, title: "That did not compute!"))
    ) {
        self.actions = actions
        self.resolvedError = resolvedError
    }

    func map(error: Error) -> RepositoryError {
        register(.map(error))

        return resolvedError
    }
}

extension ErrorMapperSpy.Action: Equatable {
    static func == (lhs: ErrorMapperSpy.Action, rhs: ErrorMapperSpy.Action) -> Bool {
        switch (lhs, rhs) {
        case let (.map(lhsError), .map(rhsError)):
            return String(describing: lhsError) == String(describing: rhsError)
        }
    }
}
