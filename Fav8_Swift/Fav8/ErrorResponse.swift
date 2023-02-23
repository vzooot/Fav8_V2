//
//  ErrorResponse.swift
//  Fav8
//
//  Created by Administrator on 12/6/22.
//

import Foundation

public enum ErrorResponse: Error {
    case error(Int, Data?, URLResponse?, Error)
}
