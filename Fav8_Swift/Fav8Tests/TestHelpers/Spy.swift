//
//  Spy.swift
//  Fav8Tests
//
//  Created by Administrator on 12/5/22.
//

import Foundation
import XCTest

protocol Spy {
    associatedtype Action: Equatable
    var actions: SpyActions<Action> { get }

    func register(_ action: Action)
    func verify(file: StaticString, line: UInt)
}

extension Spy {

    func register(_ action: Action) {
        actions.register(action)
    }

    func verify(file: StaticString = #file, line: UInt = #line) {
        actions.verify(file: file, line: line)
    }
}

protocol StaticSpy {
    associatedtype Action: Equatable
    static var actions: SpyActions<Action> { get }

    static func register(_ action: Action)
    static func verify(file: StaticString, line: UInt)
}

extension StaticSpy {

    static func register(_ action: Action) {
        actions.register(action)
    }

    static func verify(file: StaticString = #file, line: UInt = #line) {
        actions.verify(file: file, line: line)
    }
}

final class SpyActions<Action> where Action: Equatable {
    let expected: [Action]
    var factual: [Action] = []

    init(expected: [Action]) {
        self.expected = expected
    }

    fileprivate func register(_ action: Action) {
        factual.append(action)
    }

    fileprivate func verify(file: StaticString, line: UInt) {
        if factual == expected { return }
        let factualNames = factual.map { "." + String(describing: $0) }
        let expectedNames = expected.map { "." + String(describing: $0) }
        XCTFail(
            "\(name)\nExpected:\n\(expectedNames)\nReceived:\n\(factualNames)", file: file,
            line: line)
    }

    private var name: String {
        let fullName = String(describing: self)
        let nameComponents = fullName.components(separatedBy: ".")
        return nameComponents.dropLast().last ?? fullName
    }
}
