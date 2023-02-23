//
//  Publisher+Loadable.swift.swift
//  Fav8
//
//  Created by Administrator on 12/5/22.
//

import Combine
import Foundation

extension Publisher {

    func sinkToLoadable(_ completion: @escaping (Loadable<Self.Output, Self.Failure>) -> Void)
        -> AnyCancellable
    {
        sinkToResult { completion(.loaded($0)) }
    }
}

extension Publisher {

    fileprivate func sinkToResult(
        _ completion: @escaping (Result<Self.Output, Self.Failure>) -> Void
    ) -> AnyCancellable {
        return sink(
            receiveCompletion: { subscriptionCompletion in
                switch subscriptionCompletion {
                case .failure(let error):
                    completion(.failure(error))
                default:
                    return
                }
            },
            receiveValue: { value in
                completion(.success(value))
            })
    }
}
