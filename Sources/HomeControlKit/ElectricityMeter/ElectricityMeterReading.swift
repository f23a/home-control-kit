//
//  ElectricityMeterReading.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 27.09.24.
//

import Foundation

public struct ElectricityMeterReading: Codable {
    public var readingAt: Date
    public var power: Double

    public init(readingAt: Date, power: Double) {
        self.readingAt = readingAt
        self.power = power
    }
}
