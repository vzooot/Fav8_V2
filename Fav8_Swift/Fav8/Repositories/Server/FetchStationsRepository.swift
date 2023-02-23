//
//  FetchStationsRepository.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Combine
import Fav8Server
import Foundation

protocol FetchStationsRepository {
    func fetchStations() -> AnyPublisher<[RadioStation], RepositoryError>
}

struct FetchStationsDataStore: FetchStationsRepository {
    private let stationsApi: FetchStationsApiAdapter.Type
    private let dtoMapper: StationsDtoMapper
    private let repoRequestConfiguration: RepoRequestConfiguration

    init(
        stationsApi: FetchStationsApiAdapter.Type = RadioStationsAPI.self,
        dtoMapper: StationsDtoMapper = ServerDtoMapper(),
        repoRequestConfiguration: RepoRequestConfiguration = .init()
    ) {
        self.stationsApi = stationsApi
        self.dtoMapper = dtoMapper
        self.repoRequestConfiguration = repoRequestConfiguration
    }

    func fetchStations() -> AnyPublisher<[RadioStation], RepositoryError> {
        stationsApi.getAllRadioStations(id: nil)
            .tryMap { dtoMapper.map(stationsDto: $0) }
            .retry(2)
            .mapToRepoRequest(config: repoRequestConfiguration)
    }
}
