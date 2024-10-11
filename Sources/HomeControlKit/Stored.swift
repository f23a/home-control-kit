//
//  Stored.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.10.24.
//

import Foundation

public struct Stored<Value>:
    Codable, Equatable, Hashable, Identifiable
where
    Value: Codable,
    Value: Equatable,
    Value: Hashable
{
    public var id: UUID
    public var value: Value
    public var createdAt: Date
    public var updatedAt: Date?

    public init(id: UUID, value: Value, createdAt: Date, updatedAt: Date? = nil) {
        self.id = id
        self.value = value
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
