//
//  RadioStation.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Foundation

struct RadioStation: Hashable {
    var name: String
    var url: String
}

extension RadioStation {
    static var preview: RadioStation {
        return .init(name: "Station", url: "www.station.com")
    }
}
