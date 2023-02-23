//
//  AdditionalParamtersFactorySpy.swift
//  Fav8Tests
//
//  Created by Administrator on 12/11/22.
//

import Foundation

@testable import Fav8

struct AdditionalParametersFactorySpy: Spy, AdditionalParametersFactory {
    enum Action: Equatable {
        case additionalParameters
    }

    var actions: SpyActions<Action> = .init(expected: [.additionalParameters])
    let result: String = UUID().uuidString

    func additionalParameters() -> String? {
        register(.additionalParameters)

        return result
    }
}
