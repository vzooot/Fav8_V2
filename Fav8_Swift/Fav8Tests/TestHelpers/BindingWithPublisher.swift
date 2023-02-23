//
//  BindingWithPublisher.swift
//  Fav8Tests
//
//  Created by Administrator on 12/5/22.
//

import Combine
import SwiftUI
import XCTest

struct BindingWithPublisher<Value> {

    let binding: Binding<Value>
    let updatesRecorder: AnyPublisher<[Value], Never>

    init(value: Value, recordingTimeInterval: TimeInterval = 0.5) {
        var value = value
        var updates = [value]
        binding = Binding<Value>(
            get: { value },
            set: {
                value = $0
                updates.append($0)
            })
        updatesRecorder = Future<[Value], Never> { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + recordingTimeInterval) {
                completion(.success(updates))
            }
        }.eraseToAnyPublisher()
    }
}

extension AnyPublisher where Output: Equatable, Failure == Never {

    func verifyAsync(
        description: String = #function,
        expected: Output,
        in testCase: SubscribingTestCase,
        timeout: TimeInterval = 2
    ) {

        let exp = XCTestExpectation(description: description)
        sink { updates in
            XCTAssertEqual(updates, expected)
            exp.fulfill()
        }.store(in: &testCase.subscriptions)
        testCase.wait(for: [exp], timeout: timeout)
    }
}

extension AnyPublisher where Output: Equatable, Failure: Equatable {

    func verifyAsync(
        description: String = #function,
        expected: Result<Output, Failure>,
        in testCase: SubscribingTestCase,
        timeout: TimeInterval = 2,
        onFulfilled: (() -> Void)? = nil
    ) {

        switch expected {
        case .success(let output):
            verifySuccessAsync(
                description: description,
                expected: output,
                in: testCase,
                timeout: timeout,
                onFulfilled: onFulfilled)
        case .failure(let failure):
            verifyFailureAsync(
                description: description,
                expected: failure,
                in: testCase,
                timeout: timeout,
                onFulfilled: onFulfilled)
        }
    }
}

extension AnyPublisher where Output == Void, Failure: Equatable {

    func verifyAsync(
        description: String = #function,
        expected: Result<Output, Failure>,
        in testCase: SubscribingTestCase,
        timeout: TimeInterval = 2,
        onFulfilled: (() -> Void)? = nil
    ) {

        switch expected {
        case .success:
            verifySuccessAsync(
                description: description,
                in: testCase,
                timeout: timeout,
                onFulfilled: onFulfilled)
        case .failure(let failure):
            verifyFailureAsync(
                description: description,
                expected: failure,
                in: testCase,
                timeout: timeout,
                onFulfilled: onFulfilled)
        }
    }
}

extension AnyPublisher where Output: Equatable {

    func verifySuccessAsync(
        description: String = #function,
        expected: Output,
        in testCase: SubscribingTestCase,
        timeout: TimeInterval = 2,
        onFulfilled: (() -> Void)? = nil
    ) {

        let exp = XCTestExpectation(description: description)
        sink {
            switch $0 {
            case .failure(let error):
                XCTFail("Received unexpected error: \(error)")
            default:
                return
            }
        } receiveValue: { updates in
            XCTAssertEqual(updates, expected)
            onFulfilled?()
            exp.fulfill()
        }
        .store(in: &testCase.subscriptions)
        testCase.wait(for: [exp], timeout: timeout)
    }
}

extension AnyPublisher where Output == Void {

    func verifySuccessAsync(
        description: String = #function,
        in testCase: SubscribingTestCase,
        timeout: TimeInterval = 2,
        onFulfilled: (() -> Void)? = nil
    ) {

        let exp = XCTestExpectation(description: description)
        sink {
            switch $0 {
            case .failure(let error):
                XCTFail("Received unexpected error: \(error)")
            default:
                return
            }
        } receiveValue: { _ in
            onFulfilled?()
            exp.fulfill()
        }
        .store(in: &testCase.subscriptions)
        testCase.wait(for: [exp], timeout: timeout)
    }
}

extension AnyPublisher where Failure: Equatable {

    func verifyFailureAsync(
        description: String = #function,
        expected: Failure,
        in testCase: SubscribingTestCase,
        timeout: TimeInterval = 2,
        onFulfilled: (() -> Void)? = nil
    ) {

        let exp = XCTestExpectation(description: description)
        sink {
            switch $0 {
            case .failure(let error):
                XCTAssertEqual(error, expected)
                onFulfilled?()
                exp.fulfill()
            default:
                XCTFail("Received unexpected success")
                return
            }
        } receiveValue: { _ in
            XCTFail("Received unexpected success")
        }
        .store(in: &testCase.subscriptions)
        testCase.wait(for: [exp], timeout: timeout)
    }
}

class SubscribingTestCase: XCTestCase {

    var subscriptions = Set<AnyCancellable>()

    override func tearDown() {

        subscriptions = Set<AnyCancellable>()
    }
}
