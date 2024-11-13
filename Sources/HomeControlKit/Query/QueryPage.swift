//
//  QueryPage.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.11.24.
//

public struct QueryPage<T: Codable>: Codable {
    public var items: [T]
    public var metadata: QueryPageMetadata

    public init(items: [T], metadata: QueryPageMetadata) {
        self.items = items
        self.metadata = metadata
    }
}

public struct QueryPageMetadata: Codable {
    public var page: Int
    public var per: Int
    public var total: Int

    public init(page: Int, per: Int, total: Int) {
        self.page = page
        self.per = per
        self.total = total
    }
}
