//
//  ElectricityPriceQuery.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 09.11.24.
//

import Foundation

public struct ElectricityPriceQuery: Codable {
    public var pagination: QueryPagination
    public var filter: [ElectricityPriceQueryFilter]
    public var sort: QuerySort<ElectrityPriceQuerySort>

    public init(
        pagination: QueryPagination,
        filter: [ElectricityPriceQueryFilter],
        sort: QuerySort<ElectrityPriceQuerySort>
    ) {
        self.pagination = pagination
        self.filter = filter
        self.sort = sort
    }
}

public enum ElectricityPriceQueryFilter: Codable {
    case startsAt(_ filter: QueryFilter<Date>)
}

public enum ElectrityPriceQuerySort: String, Codable {
    case startsAt
}
