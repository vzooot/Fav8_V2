//
//  FetchStationsApiAdapter.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Combine
import Fav8Server
import Foundation

protocol FetchStationsApiAdapter {
    static func getAllRadioStations(id: Int?) -> AnyPublisher<[StationDto], Error>
}

extension RadioStationsAPI: FetchStationsApiAdapter {}

typealias DefaultFetchStationsApiAdapter = RadioStationsAPI
