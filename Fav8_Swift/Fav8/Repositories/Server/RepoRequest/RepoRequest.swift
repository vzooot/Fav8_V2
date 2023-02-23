//
//  RepoRequest.swift
//  Fav8
//
//  Created by Administrator on 12/6/22.
//

import Combine
import Foundation

extension Publisher where Failure: Error {
    func mapToRepoRequest(config: RepoRequestConfiguration) -> AnyPublisher<Output, RepositoryError>
    {
        self
            .mapError { config.errorMapper.map(error: $0) }
            //            .catch { config.errorInterceptor.interceptErrorIfNeeded(outputType: Output.self, repositoryError: $0) }
            .eraseToAnyPublisher()
    }
}

// MARK: - RepoRequest + Configuration

struct RepoRequestConfiguration {
    //    let locale: Locale.Type
    //    let requestIdFactory: RequestIdFactory
    let additionalParametersFactory: AdditionalParametersFactory
    let errorMapper: RepositoryErrorMapper
    //    let errorInterceptor: ErrorResponseInterceptor

    init(
        //        locale: Locale.Type = Locale.self,
        //        requestIdFactory: RequestIdFactory = RepoRequestIdFactory(),
        additionalParametersFactory: AdditionalParametersFactory =
            UserDefaultsAdditionalParametersFactory(),
        errorMapper: RepositoryErrorMapper = NetworkRepositoryErrorMapper()
            //        ,
            //        errorInterceptor: ErrorResponseInterceptor = UnauthorizedErrorInterceptor()
    ) {
        //        self.locale = locale
        //        self.requestIdFactory = requestIdFactory
        self.additionalParametersFactory = additionalParametersFactory
        self.errorMapper = errorMapper
        //        self.errorInterceptor = errorInterceptor
    }
}

// MARK: - Request Id Factory

protocol RequestIdFactory {
    func createRequestId() -> UUID
}

extension RepoRequestConfiguration {
    struct RepoRequestIdFactory {
        func createRequestId() -> UUID {
            let requestId = UUID()
            #if DEBUG
                print("[RequestIdFactory]: \(requestId)")
            #endif
            return requestId
        }
    }
}

extension RepoRequestConfiguration.RepoRequestIdFactory: RequestIdFactory {}
