//
//  ElectricityPrice.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 03.11.24.
//

import Foundation

public struct ElectricityPrice: Codable, Equatable, Hashable {
    public var startsAt: Date
    public var total: Double
    public var energy: Double
    public var tax: Double

    public init(startsAt: Date, total: Double, energy: Double, tax: Double) {
        self.startsAt = startsAt
        self.total = total
        self.energy = energy
        self.tax = tax
    }
}
