//
//  RepositoryErrorMapper.swift
//  Fav8
//
//  Created by Administrator on 12/6/22.
//

import Foundation

//import SpaceBurritoServer

protocol RepositoryErrorMapper {
    func map(error: Error) -> RepositoryError
}

protocol RepositoryErrorFactory {
    func errorFrom(
        errorCode: Int, title: String, errorId: String?,
        detail: String?, instance: String?
    ) -> RepositoryError
}

// MARK: - NetworkRepositiryErrorMapper+RepositoryErrorMapper

struct NetworkRepositoryErrorMapper: RepositoryErrorMapper {
    func map(error: Error) -> RepositoryError {
        if let repoError = error as? RepositoryError {
            return repoError
        }

        switch error {
        case let urlError as URLError:
            return map(urlError: urlError)
        case let errorResponse as ErrorResponse:
            return map(errorResponse: errorResponse)
        case let nsError as NSError:
            return map(nsError: nsError)
        default:
            return .defaultError(title: error.localizedDescription)
        }
    }

    private func map(urlError: URLError) -> RepositoryError {
        switch urlError.code {
        case .timedOut:
            return .timeout(
                .init(
                    code: urlError.errorCode,
                    title: urlError.localizedDescription))
        case .notConnectedToInternet:
            return .noConnection(
                .init(
                    code: urlError.errorCode,
                    title: urlError.localizedDescription))
        default:
            return errorFrom(
                errorCode: urlError.errorCode,
                title: urlError.localizedDescription)
        }
    }

    private func map(errorResponse: ErrorResponse) -> RepositoryError {
        switch errorResponse {
        case .error(let code, let data, _, let error):
            return map(errorCode: code, problemData: data, error: error)
        }
    }

    private func map(nsError: NSError) -> RepositoryError {
        errorFrom(
            errorCode: nsError.code,
            title: nsError.localizedDescription)
    }

    private func map(errorCode: Int, problemData: Data?, error: Error) -> RepositoryError {
        guard let problemData = problemData else {
            return errorFrom(
                errorCode: errorCode,
                title: error.localizedDescription)
        }

        //        switch CodableHelper.decode(ProblemDto.self, from: problemData) {
        //        case .success(let errorDto):
        //            return errorFrom(errorCode: errorCode,
        //                             title: errorDto.title,
        //                             errorId: errorDto.errorId,
        //                             detail: errorDto.detail,
        //                             instance: errorDto.instance)
        //        case .failure(let error):
        return errorFrom(
            errorCode: errorCode,
            title: error.localizedDescription)
        //        }
    }
}

// MARK: - NetworkRepositiryErrorMapper+RepositoryErrorFactory

extension NetworkRepositoryErrorMapper: RepositoryErrorFactory {
    func errorFrom(
        errorCode: Int, title: String, errorId: String? = nil,
        detail: String? = nil, instance: String? = nil
    ) -> RepositoryError {
        //        switch HttpError(statusCode: errorCode) {
        //        case .badRequest:
        //            return .badRequest(.init(code: errorCode, title: title, errorId: errorId,
        //                                     detail: detail, instance: instance))
        //        case .unauthorized:
        //            return .unauthorized(.init(code: errorCode, title: title, errorId: errorId,
        //                                       detail: detail, instance: instance))
        //        case .forbidden:
        //            return .forbidden(.init(code: errorCode, title: title, errorId: errorId,
        //                                    detail: detail, instance: instance))
        //        case .notFound:
        //            return .notFound(.init(code: errorCode, title: title, errorId: errorId,
        //                                   detail: detail, instance: instance))
        //        default:
        return .unexpected(
            .init(
                code: errorCode, title: title, errorId: errorId,
                detail: detail, instance: instance))
        //        }
    }
}
