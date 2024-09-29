//
//  StoredElectricityMeterReading.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 27.09.24.
//

import Foundation

public struct StoredElectricityMeterReading: Codable, Identifiable {
    public var id: UUID
    public var reading: ElectricityMeterReading
    public var createdAt: Date
    public var updatedAt: Date?

    public init(id: UUID, reading: ElectricityMeterReading, createdAt: Date, updatedAt: Date? = nil) {
        self.id = id
        self.reading = reading
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
