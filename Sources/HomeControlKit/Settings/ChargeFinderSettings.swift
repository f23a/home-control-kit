//
//  ChargeFinderSettings.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.11.24.
//

import Foundation

public struct ChargeFinderSettings: Codable {
    public var rangeTimeInterval: TimeInterval
    public var numberOfCompareRanges: Int
    public var compareRangePercentage: Double
    public var minimumForceChargingRangeTimeInterval: TimeInterval
    public var maximumForceChargingRangeTimeInterval: TimeInterval
    public var maximumElectricityPrice: Double
    public var isVehicleChargingAllowed: Bool?
    public var targetStateOfCharge: Double?

    public init(
        rangeTimeInterval: TimeInterval,
        numberOfCompareRanges: Int,
        compareRangePercentage: Double,
        minimumForceChargingRangeTimeInterval: TimeInterval,
        maximumForceChargingRangeTimeInterval: TimeInterval,
        maximumElectricityPrice: Double,
        isVehicleChargingAllowed: Bool?,
        targetStateOfCharge: Double?
    ) {
        self.rangeTimeInterval = rangeTimeInterval
        self.numberOfCompareRanges = numberOfCompareRanges
        self.compareRangePercentage = compareRangePercentage
        self.minimumForceChargingRangeTimeInterval = minimumForceChargingRangeTimeInterval
        self.maximumForceChargingRangeTimeInterval = maximumForceChargingRangeTimeInterval
        self.maximumElectricityPrice = maximumElectricityPrice
        self.isVehicleChargingAllowed = isVehicleChargingAllowed
        self.targetStateOfCharge = targetStateOfCharge
    }
}
