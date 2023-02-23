//
//  FetchStationsUseCaseTests.swift
//  Fav8Tests
//
//  Created by Administrator on 12/5/22.
//

import Combine
import XCTest

@testable import Fav8

final class FetchStationsUseCaseTests: SubscribingTestCase {
    func testCanSuccesfulyFetchStations() throws {
        // Given
        let stations: [RadioStation] = [.preview]
        let fetchStationsRepositorySpy = FetchStationsRepositorySpy(
            actions: .init(expected: [.fetchStations]), result: .success(stations))

        // When
        let sut = FetchStationsInteractor(fetchStationsRepository: fetchStationsRepositorySpy)
        let result = sut.fetchStations()

        // Then
        result.verifySuccessAsync(expected: stations, in: self) {
            fetchStationsRepositorySpy.verify()
        }
    }

    func testFailingToFetchStationsWillReturnError() throws {
        // Given
        let repositoryError = RepositoryError.unexpected(.preview)
        let fetchStationsRepositorySpy: FetchStationsRepositorySpy = .init(
            actions: .init(expected: [.fetchStations]), result: .failure(repositoryError))
        let sut = FetchStationsInteractor(fetchStationsRepository: fetchStationsRepositorySpy)

        // When
        let result = sut.fetchStations()

        // Then
        result.verifyFailureAsync(expected: repositoryError, in: self) {
            fetchStationsRepositorySpy.verify()
        }
    }
}

// MARK: - Test helpers

extension FetchStationsUseCaseTests {
    fileprivate struct FetchStationsRepositorySpy: Spy, FetchStationsRepository {
        enum Action: Equatable {
            case fetchStations
        }

        var actions: SpyActions<Action>

        let result: Result<[RadioStation], RepositoryError>

        func fetchStations() -> AnyPublisher<[RadioStation], RepositoryError> {
            register(.fetchStations)
            return (result.publisher.eraseToAnyPublisher())
        }
    }
}
