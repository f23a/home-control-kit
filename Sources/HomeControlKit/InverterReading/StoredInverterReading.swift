//
//  StoredInverterReading.swift
//  HomeControlKit
//
//  Created by Christoph Pageler on 05.05.24.
//

import Foundation

public struct StoredInverterReading: Codable, Identifiable {
    public var id: UUID
    public var reading: InverterReading
    public var createdAt: Date
    public var updatedAt: Date?

    public init(id: UUID, reading: InverterReading, createdAt: Date, updatedAt: Date? = nil) {
        self.id = id
        self.reading = reading
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
