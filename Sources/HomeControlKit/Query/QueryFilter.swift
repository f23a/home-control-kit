//
//  QueryFilter.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.11.24.
//

public struct QueryFilter<T: Codable>: Codable {
    public var value: T
    public var method: QueryFilterMethod

    public init(value: T, method: QueryFilterMethod) {
        self.value = value
        self.method = method
    }
}
