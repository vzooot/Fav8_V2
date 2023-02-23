//
//  DtoSeeds.swift
//  Fav8
//
//  Created by Administrator on 12/11/22.
//

import Foundation

@testable import Fav8Server

// MARK: - UserInfoDto

// MARK: - FaqListDto

extension StationDto {
    static func mock() -> StationDto {
        .init(id: UUID().uuidString, stationName: "StationName", stationUrl: "StationUrl")
    }
}
