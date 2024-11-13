//
//  QuerySort.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.11.24.
//

public struct QuerySort<T: Codable>: Codable {
    public var value: T
    public var direction: QuerySortDirection

    public init(value: T, direction: QuerySortDirection) {
        self.value = value
        self.direction = direction
    }
}
