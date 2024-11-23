//
//  ElectricityMeterReadingQuery.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 22.11.24.
//

import Foundation

public struct ElectricityMeterReadingQuery: Codable {
    public var pagination: QueryPagination
    public var filter: [ElectricityMeterReadingQueryFilter]
    public var sort: QuerySort<ElectricityMeterReadingQuerySort>

    public init(
        pagination: QueryPagination,
        filter: [ElectricityMeterReadingQueryFilter],
        sort: QuerySort<ElectricityMeterReadingQuerySort>
    ) {
        self.pagination = pagination
        self.filter = filter
        self.sort = sort
    }
}

public enum ElectricityMeterReadingQueryFilter: Codable {
    case readingAt(_ filter: QueryFilter<Date>)
    case power(_ filter: QueryFilter<Double>)
}

public enum ElectricityMeterReadingQuerySort: String, Codable {
    case readingAt
    case power
}
