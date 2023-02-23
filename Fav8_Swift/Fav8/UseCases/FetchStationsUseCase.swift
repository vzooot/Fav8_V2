//
//  FetchStationsUseCase.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Combine
import Foundation

protocol FetchStationsUseCase {
    func fetchStations() -> AnyPublisher<[RadioStation], RepositoryError>
}

struct FetchStationsInteractor: FetchStationsUseCase {
    private let fetchStationsRepository: FetchStationsRepository

    init(fetchStationsRepository: FetchStationsRepository = FetchStationsDataStore()) {
        self.fetchStationsRepository = fetchStationsRepository
    }

    func fetchStations() -> AnyPublisher<[RadioStation], RepositoryError> {
        fetchStationsRepository.fetchStations()
    }
}
