//
//  FetchStationsRepositoryTests.swift
//  Fav8
//
//  Created by Administrator on 12/6/22.
//

import Combine
import XCTest

@testable import Fav8
@testable import Fav8Server

final class FetchStationsRepositoryTests: SubscribingTestCase {
    func testSuccessfullyFetchStationsShouldMap() {
        // Given
        let apiSpy = RadioStationsAPISpy.self
        let stationsDto: StationDto = .mock()
        let stations: [RadioStation] = [.preview]
        let dtoMapperSpy = StationsMapperSpy(
            actions: .init(expected: [.map([stationsDto])]),
            result: stations)

        let repoConfigSpy = RepoRequestConfigurationSpy(
            additionalParametersFactorySpy: .init(actions: .init(expected: [])))

        let sut: FetchStationsRepository = FetchStationsDataStore(
            stationsApi: apiSpy,
            dtoMapper: dtoMapperSpy,
            repoRequestConfiguration: repoConfigSpy.repoConfig)

        apiSpy.expect(
            actions: .init(expected: [RadioStationsAPISpy.Action.getAllRadioStations]),
            result: .success([stationsDto]))

        // When
        let result = sut.fetchStations()

        // Then
        result.verifySuccessAsync(expected: stations, in: self) {
            apiSpy.verify()
            dtoMapperSpy.verify()
            repoConfigSpy.verify()
        }
    }

    func testFailingToFetchStationsShouldMapError() {
        // Given
        let expectedError = URLError(.badServerResponse)
        let apiSpy = RadioStationsAPISpy.self
        let dtoMapperSpy = StationsMapperSpy()

        let repoConfigSpy = RepoRequestConfigurationSpy(
            additionalParametersFactorySpy: .init(actions: .init(expected: [])),
            errorMapperSpy: .init(.init(expected: [.map(expectedError)]), resolvedError: .preview))

        let sut: FetchStationsRepository = FetchStationsDataStore(
            stationsApi: apiSpy,
            dtoMapper: dtoMapperSpy,
            repoRequestConfiguration: repoConfigSpy.repoConfig)

        apiSpy.expect(
            actions: .init(expected: [.getAllRadioStations]), result: .failure(expectedError))

        // When
        let result = sut.fetchStations()

        // Then
        result.verifyFailureAsync(expected: repoConfigSpy.errorMapperSpy.resolvedError, in: self) {
            apiSpy.verify()
            dtoMapperSpy.verify()
            repoConfigSpy.verify()
        }
    }
}

// MARK: - Test helpers

extension FetchStationsRepositoryTests {
    struct RadioStationsAPISpy: StaticSpy, FetchStationsApiAdapter {
        enum Action: Equatable {
            case getAllRadioStations
        }

        static var actions: SpyActions<Action> = .init(expected: [])
        static var result: Result<[StationDto], Error> = .failure(error)
        static let error = NSError(domain: NSURLErrorDomain, code: 401, userInfo: nil)

        static func expect(
            actions: SpyActions<Action> = .init(expected: []),
            result: Result<[StationDto], Error>
        ) {
            self.actions = actions
            self.result = result
        }

        static func getAllRadioStations(id: Int?) -> AnyPublisher<[StationDto], Error> {
            register(.getAllRadioStations)

            return result.publisher.eraseToAnyPublisher()
        }
    }

    struct StationsMapperSpy: Spy, StationsDtoMapper {
        enum Action: Equatable {
            case map([StationDto])
        }

        var actions: SpyActions<Action>
        let result: [RadioStation]

        init(
            actions: SpyActions<Action> = .init(expected: []),
            result: [RadioStation] = [RadioStation.preview]
        ) {
            self.actions = actions
            self.result = result
        }

        func map(stationsDto dto: [StationDto]) -> [RadioStation] {
            register(.map(dto))
            return result
        }
    }
}
