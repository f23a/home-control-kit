//
//  StoredElectricityMeter.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 27.09.24.
//

import Foundation

public struct StoredElectricityMeter: Codable, Identifiable, Equatable, Hashable {
    public var id: UUID
    public var meter: ElectricityMeter
    public var createdAt: Date
    public var updatedAt: Date?

    public init(id: UUID, meter: ElectricityMeter, createdAt: Date, updatedAt: Date? = nil) {
        self.id = id
        self.meter = meter
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
