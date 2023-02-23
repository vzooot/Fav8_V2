//
//  RepositoryError.swift
//  Fav8
//
//  Created by Administrator on 12/4/22.
//

import Foundation

enum RepositoryError: Error {

    /**
     The error produced by a bad request
     Should be considered final
     */
    case badRequest(Problem)

    /**
     The error produced by an unauthorized attempt to fetch data
     Could be retried after a new token has been resolved
     */
    case unauthorized(Problem)

    /**
     The error produced by a forbidden attempt to fetch data
     Should be considered final
     */
    case forbidden(Problem)

    /**
     The error produced when a resource can not be located
     Should be considered final
     */
    case notFound(Problem)

    /**
     The error produced when an attempt to fetch data has timed out
     Could be retried automatically or initialized by the user
     */
    case timeout(Problem)

    /**
     The error produced whwn there is no connection available.
     Could be retried automatically or initialized by the user.
     */
    case noConnection(Problem)

    /**
     An unforseen error has occured
     Should be considered final
     */
    case unexpected(Problem)

    // MARK: - Default error

    private static let defaultPaymentErrorCode = -42

    /**
     Utility error for cases where you might receive a false positive or other.
     */
    static func defaultError(title: String = "") -> RepositoryError {

        return .unexpected(.init(code: defaultPaymentErrorCode, title: title))
    }
}

extension RepositoryError: Equatable {}

extension RepositoryError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unexpected(let problem),
            .badRequest(let problem),
            .forbidden(let problem),
            .noConnection(let problem),
            .notFound(let problem),
            .timeout(let problem),
            .unauthorized(let problem):
            return "\(problem.title) (\(problem.code))"
        }
    }
}

extension RepositoryError {

    /**
     Helper for displaying  problem info in error UI if enabled.

     *Example:*
     ```
     Text(error.displayableError("failedFetchingSomethingDetail")
     ```

     - parameter localizedTitle: The key to the localized string to display.
     - returns: The localized resource for the input key, decorated if needed.
     */
    func displayableError(_ localizedTitle: String) -> String {

        #if FEATURE_DECORATED_REPO_ERRORS_ENABLED
            return "\(localizedTitle.localized) (\(localizedDescription))"
        #else
            return localizedTitle
        #endif
    }
}

#if DEBUG

    extension RepositoryError {

        static let preview = RepositoryError.unexpected(.preview)
    }

#endif
