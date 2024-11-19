//
//  ForceCharger.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.10.24.
//

import Foundation

public struct ForceCharger {
    /// Amout of time where the force charger is looking into the future searching for ranges
    public var planningRange: TimeInterval = 24.hours

    /// Maximum number of ranges, that will be sent
    public var maximumNumberOfRanges: Int = 2

    /// `threshold` is calculated from the beginning of `planningRange`, for example the first 2h of 24h
    public var threshold: TimeInterval = 2.hours

    private let provider: ForceChargerRangeProvider

    public init(provider: ForceChargerRangeProvider) {
        self.provider = provider
    }

    public func execute(at date: Date = Date()) async throws -> ForceChargerResult {
        // Define date ranges
        let planningDateRange = planningDateRange(at: date)
        let thresholdDateRange = thresholdDateRange(at: date)

        // Get force charging ranges from provider for planning date range
        let forceChargingRanges = try await provider.forceChargingRanges(in: planningDateRange)

        // Skip execution when ranges contains any item which was sent already
        let containsSent = forceChargingRanges.contains(where: { $0.value.state == .sent })
        guard !containsSent else { return .skip(reason: .containsSent) }

        // Get planned ranges and those who are in threshold already
        let plannedRanges = forceChargingRanges.filter { $0.value.state == .planned }
        let plannedRangesInThreshold = plannedRanges.filter { $0.value.dateRange.overlaps(thresholdDateRange) }

        // Check if we reached the threshold
        let hasPlanedRangesInTreshold = !plannedRangesInThreshold.isEmpty
        guard hasPlanedRangesInTreshold else { return .skip(reason: .waitForThreshold) }

        // Get maxmimum number of planned ranges
        let firstMaxPlannedRanges = Array(plannedRanges.prefix(maximumNumberOfRanges))

        return .send(ranges: firstMaxPlannedRanges)
    }

    private func planningDateRange(at date: Date) -> Range<Date> { date..<date.addingTimeInterval(planningRange) }

    private func thresholdDateRange(at date: Date) -> Range<Date> { date..<date.addingTimeInterval(threshold) }
}

public protocol ForceChargerRangeProvider {
    func forceChargingRanges(in range: Range<Date>) async throws -> [Stored<ForceChargingRange>]
}

public enum ForceChargerResult: Equatable {
    case skip(reason: ForceChargerSkipReason)
    case send(ranges: [Stored<ForceChargingRange>])
}

public enum ForceChargerSkipReason: Equatable {
    case containsSent
    case waitForThreshold
}
