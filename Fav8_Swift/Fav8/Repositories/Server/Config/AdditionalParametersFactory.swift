//
//  AdditionalParametersFactory.swift
//  Fav8
//
//  Created by Administrator on 12/6/22.
//

import Foundation

protocol AdditionalParametersFactory {
    func additionalParameters() -> String?
}

struct UserDefaultsAdditionalParametersFactory: AdditionalParametersFactory {

    private let userDefaultsAdapter: UserDefaultsAdapter
    private let encoder: JSONEncoder

    init(
        userDefaultsAdapter: UserDefaultsAdapter = UserDefaults.standard,
        encoder: JSONEncoder = .init()
    ) {

        self.userDefaultsAdapter = userDefaultsAdapter
        self.encoder = encoder
    }

    func additionalParameters() -> String? {
        #if FEATURE_ADDITIONAL_PARAMETERS_ENABLED
            let additionalParameters = AdditionalParameters(
                webpayDelayMs: userDefaultsAdapter.integer(for: .webpayDelayMs),
                webPayErrorCode: userDefaultsAdapter.integer(for: .webPayErrorCode),
                salesFinanceDelayMs: userDefaultsAdapter.integer(for: .salesFinanceDelayMs),
                salesFinanceErrorCode: userDefaultsAdapter.integer(for: .salesFinanceErrorCode)
            )

            return (try? encoder.encode(additionalParameters))
                .flatMap { String(data: $0, encoding: .utf8) }
        #else
            return nil
        #endif
    }
}

// MARK: - Config & AdditionalParameters

extension UserDefaultsAdditionalParametersFactory {

    fileprivate enum Config: String {
        case webpayDelayMs = "wp_delay_ms"
        case webPayErrorCode = "wp_error_code"
        case salesFinanceDelayMs = "sf_delay_ms"
        case salesFinanceErrorCode = "sf_error_code"
    }
}

// MARK: - UserDefaults + UserDefaultsAdditionalParametersFactory.Config

extension UserDefaultsAdapter {

    fileprivate func integer(for config: UserDefaultsAdditionalParametersFactory.Config) -> Int? {

        let result = integer(forKey: config.rawValue)

        return result > 0 ? result : nil
    }
}

// MARK: - UserDefaultsAdapter

protocol UserDefaultsAdapter {
    func integer(forKey defaultName: String) -> Int
    func setValue(_ value: Any?, forKey key: String)
    func string(forKey defaultName: String) -> String?
    func removeObject(forKey defaultName: String)
}

typealias DefaultUserAdapter = UserDefaults
extension UserDefaults: UserDefaultsAdapter {}
