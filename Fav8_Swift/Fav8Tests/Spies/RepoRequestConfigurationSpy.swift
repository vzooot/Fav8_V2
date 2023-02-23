//
//  RepoRequestConfigurationSpy.swift
//  Fav8Tests
//
//  Created by Administrator on 12/6/22.
//

import Foundation

@testable import Fav8

struct RepoRequestConfigurationSpy {
    //    let requestIdFactorySpy: RequestIdFactorySpy
    let additionalParametersFactorySpy: AdditionalParametersFactorySpy
    let errorMapperSpy: ErrorMapperSpy
    //    let errorInterceptorSpy: ErrorInterceptorSpy
    let repoConfig: RepoRequestConfiguration

    init(
        //        requestIdFactorySpy: RequestIdFactorySpy = .init(),
        additionalParametersFactorySpy: AdditionalParametersFactorySpy = .init(),
        errorMapperSpy: ErrorMapperSpy = .init()
    ) {
        //        self.requestIdFactorySpy = requestIdFactorySpy
        self.additionalParametersFactorySpy = additionalParametersFactorySpy
        self.errorMapperSpy = errorMapperSpy
        //        self.errorInterceptorSpy = .init(errorMapperSpy: errorMapperSpy)

        self.repoConfig = .init(
            //            locale: Locale.self,
            //                                requestIdFactory: requestIdFactorySpy,
            additionalParametersFactory: additionalParametersFactorySpy,
            errorMapper: errorMapperSpy
                //                                ,
                //                                errorInterceptor: errorInterceptorSpy
        )
    }

    func verify() {
        //        requestIdFactorySpy.verify()
        additionalParametersFactorySpy.verify()
        errorMapperSpy.verify()
        //        errorInterceptorSpy.verify()
    }
}

// extension ErrorInterceptorSpy {
//
//    init(errorMapperSpy: ErrorMapperSpy) {
//        guard errorMapperSpy.actions.expected.count > 0 else {
//            self = .init()
//            return
//        }
//
//        self = .init(
//            actions: .init(
//                expected: errorMapperSpy.actions.expected.map({ _ in
//                    .interceptErrorIfNeeded(errorMapperSpy.resolvedError)
//                })
//            )
//        )
//    }
// }
