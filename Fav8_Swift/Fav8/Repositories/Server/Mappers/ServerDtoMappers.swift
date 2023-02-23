//
//  ServerDtoMappers.swift
//  Fav8
//
//  Created by Administrator on 12/11/22.
//

import Combine
import Fav8Server
import Foundation

// MARK: - Mapper errors

struct ServerDtoMapper {
    enum MapperError: Error {
        case unknown
    }
}

// MARK: - Fetch Stations

protocol StationsDtoMapper {
    func map(stationsDto dto: [StationDto]) -> [RadioStation]
}

extension ServerDtoMapper: StationsDtoMapper {
    func map(stationsDto dto: [StationDto]) -> [RadioStation] {
        dto.map { .init(name: $0.stationName, url: $0.stationUrl)
        }
    }
}

// MARK: - Helpers

extension ServerDtoMapper {
    //    // MARK: - DTO + Domain
    //
    //    func mapMerchant(dto: MerchantDto) -> Merchant {
    //
    //        .init(logotype: dto.storeLogo.flatMap { URL(string: $0) },
    //              name: dto.storeName)
    //    }
    //
    //    func mapMoney(dto: MoneyDto) throws -> Money {
    //
    //        guard let decimalValue = Decimal(decodableString: dto.amount) else {
    //
    //            throw MapperError.unknown
    //        }
    //
    //        return .init(amount: decimalValue,
    //                     currency: mapCurrency(dto: dto.currency))
    //    }
    //
    //    func mapOptionalMoney(dto: MoneyDto?) throws -> Money? {
    //
    //        try dto.flatMap { try mapMoney(dto: $0) }
    //    }
    //
    //    func mapCurrency(dto: CurrencyDto) -> Currency {
    //
    //        .init(locale: Locale(identifier: dto.locale),
    //              code: dto.code)
    //    }
    //
    //    func mapBusinessArea(dto: String) -> BusinessArea? {
    //        BusinessArea(rawValue: dto)
    //    }
    //
    //    func mapPaymentStatusUnpaid(dto: PaymentStatusUnpaidInfoDto) -> RequestForPaymentStatus.UnpaidInfo {
    //
    //        .init(daysUntilDueDate: dto.daysUntilDueDate,
    //              soonOverdue: dto.soonOverdue)
    //    }
    //
    //    func mapPaymentStatusOverDue(dto: PaymentStatusOverdueInfoDto) -> RequestForPaymentStatus.OverdueInfo? {
    //
    //        .init(daysSinceDueDate: dto.daysSinceDueDate)
    //    }
    //
    //    // MARK: Domain + DTO
    //
    //    func map(money: Money) -> MoneyDto {
    //
    //        .init(amount: .init(describing: money.amount),
    //              currency: .init(locale: money.currency.locale.identifier,
    //                              code: money.currency.code))
    //    }
}
