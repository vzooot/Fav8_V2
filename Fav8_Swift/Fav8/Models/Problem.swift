//
//  Problem.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Foundation

struct Problem {
    let code: Int
    let title: String
    let errorId: String?
    let detail: String?
    let instance: String?

    /**
     Represents an error received as a JSON payload from the server

     Based on the  Problem Details for HTTP APIs RFC: https://datatracker.ietf.org/doc/html/rfc7807

     - Parameters
        - code: The error code
        - title: A short, human-readable summary of the problem type.  It SHOULD NOT change from occurrence to occurrence.
        - errorId: An error identifier to help track errors received client side in logs and support systems.
        - detail: A human-readable explanation specific to this occurrence of the problem.
        - instance: A URI reference that identifies the specific occurrence of the problem (may not yield further information if dereferenced).
     */
    init(
        code: Int, title: String, errorId: String? = nil,
        detail: String? = nil, instance: String? = nil
    ) {
        self.code = code
        self.title = title
        self.errorId = errorId
        self.detail = detail
        self.instance = instance
    }
}

extension Problem: Equatable {}

#if DEBUG

    // MARK: - Preview

    extension Problem {
        static let preview = Problem(code: 500, title: "Unexpected error")
    }

#endif
