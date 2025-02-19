//
//  ForceChargingRange.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.10.24.
//

import Foundation

public struct ForceChargingRange: Codable, Equatable, Hashable {
    public var startsAt: Date
    public var endsAt: Date
    public var targetStateOfCharge: Double
    public var state: ForceChargingRangeState
    public var source: ForceChargingRangeSource
    public var isVehicleChargingAllowed: Bool

    public init(
        startsAt: Date,
        endsAt: Date,
        targetStateOfCharge: Double,
        state: ForceChargingRangeState,
        source: ForceChargingRangeSource,
        isVehicleChargingAllowed: Bool
    ) {
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.targetStateOfCharge = targetStateOfCharge
        self.state = state
        self.source = source
        self.isVehicleChargingAllowed = isVehicleChargingAllowed
    }

    public var dateRange: Range<Date> { startsAt..<endsAt }
}
