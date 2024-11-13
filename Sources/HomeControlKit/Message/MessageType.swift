//
//  MessageType.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 16.10.24.
//

public enum MessageType: String, Codable, Equatable, Hashable, Sendable {
    case inverterForceChargingEnabled
    case inverterForceChargingDisabled

    case electricityPricesUpdated

    case chargeFinderCreatedForceChargingRanges
}
