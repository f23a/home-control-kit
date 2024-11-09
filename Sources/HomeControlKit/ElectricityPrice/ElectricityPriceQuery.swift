//
//  ElectricityPriceQuery.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 09.11.24.
//

import Foundation

public struct ElectricityPriceQuery: Codable {
    public var range: Range?

    public init(range: Range? = nil) {
        self.range = range
    }

    public struct Range: Codable {
        public var startsAt: Date
        public var endsAt: Date

        public init(startsAt: Date, endsAt: Date) {
            self.startsAt = startsAt
            self.endsAt = endsAt
        }
    }
}
