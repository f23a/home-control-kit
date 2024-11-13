//
//  QueryPagination.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.11.24.
//

public struct QueryPagination: Codable {
    public var page: Int
    public var per: Int

    public init(page: Int, per: Int) {
        self.page = page
        self.per = per
    }
}
