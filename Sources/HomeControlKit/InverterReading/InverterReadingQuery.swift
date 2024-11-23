//
//  InverterReadingQuery.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 22.11.24.
//

import Foundation

public struct InverterReadingQuery: Codable {
    public var pagination: QueryPagination
    public var filter: [InverterReadingQueryFilter]
    public var sort: QuerySort<InverterReadingQuerySort>

    public init(
        pagination: QueryPagination,
        filter: [InverterReadingQueryFilter],
        sort: QuerySort<InverterReadingQuerySort>
    ) {
        self.pagination = pagination
        self.filter = filter
        self.sort = sort
    }
}

public enum InverterReadingQueryFilter: Codable {
    case readingAt(_ filter: QueryFilter<Date>)
}

public enum InverterReadingQuerySort: String, Codable {
    case readingAt
}
