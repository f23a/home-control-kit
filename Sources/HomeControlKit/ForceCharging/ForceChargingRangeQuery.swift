//
//  ForceChargingRangeQuery.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 15.10.24.
//

import Foundation

public struct ForceChargingRangeQuery: Codable {
    public var pagination: QueryPagination
    public var filter: [ForceChargingRangeQueryFilter]
    public var sort: QuerySort<ForceChargingRangeQuerySort>

    public init(
        pagination: QueryPagination,
        filter: [ForceChargingRangeQueryFilter],
        sort: QuerySort<ForceChargingRangeQuerySort>
    ) {
        self.pagination = pagination
        self.filter = filter
        self.sort = sort
    }
}

public enum ForceChargingRangeQueryFilter: Codable {
    case startsAt(_ filter: QueryFilter<Date>)
    case endsAt(_ filter: QueryFilter<Date>)
}

public enum ForceChargingRangeQuerySort: String, Codable {
    case startsAt
    case endsAt
}
