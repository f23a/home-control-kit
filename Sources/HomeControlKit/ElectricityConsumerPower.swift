//
//  ElectricityConsumerPower.swift
//  HomeControlKit
//
//  Created by Christoph Pageler on 06.05.24.
//

import Foundation

public struct ElectricityConsumerPower: Codable {
    public var date: Date
    public var power: Double
    public var consumerType: ElectricityConsumerType

    public init(date: Date, power: Double, consumerType: ElectricityConsumerType) {
        self.date = date
        self.power = power
        self.consumerType = consumerType
    }
}

public enum ElectricityConsumerType: String, Codable, CaseIterable {
    case car
}
