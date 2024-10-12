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

    /// Minimum number of ranges, that must be inside the planning range, to allow sending the ranges
    public var minimumNumberOfRanges: Int = 2

    /// Maximum umber of ranges, that will be sent
    public var maximumNumberOfRanges: Int = 2

    /// `threshold` is calculated from the beginning of `planningRange`, for example the first 2h of 24h
    /// When there is a planning range inside `threshold`, `minimumNumberOfRanges` is ignored and sending the ranges is allowed
    public var threshold: TimeInterval = 2.hours

    private let provider: ForceChargerRangeProvider

    private let sender: ForceChargerRangeSender

    public init(
        provider: ForceChargerRangeProvider,
        sender: ForceChargerRangeSender
    ) {
        self.provider = provider
        self.sender = sender
    }

    public func execute(at date: Date = Date()) async throws -> ForceChargerResult {
        // Define date ranges
        let planningDateRange = planningDateRange(at: date)
        let thresholdDateRange = thresholdDateRange(at: date)

        // Get force charging ranges from provider for planning date range
        let forceChargingRanges = try await provider.forceChargingRanges(in: planningDateRange)

        // Skip execution when ranges contains any item which was sent already
        let containsSent = forceChargingRanges.contains(where: { $0.value.state == .sent })
        guard !containsSent else { return .skipped(reason: .containsSent) }

        // Get planned ranges and those who are in threshold already
        let plannedRanges = forceChargingRanges.filter { $0.value.state == .planned }
        let plannedRangesInThreshold = plannedRanges.filter { $0.value.dateRange.overlaps(thresholdDateRange) }

        // Check if we reached the minimum number of ranges, or if anything is in threshold
        let reachedMinimum = plannedRanges.count >= minimumNumberOfRanges
        let hasPlanedRangesInTreshold = !plannedRangesInThreshold.isEmpty
        guard reachedMinimum || hasPlanedRangesInTreshold else { return .skipped(reason: .waitForMinimumOfRanges) }

        // Get maxmimum number of planned ranges
        let firstMaxPlannedRanges = Array(plannedRanges.prefix(maximumNumberOfRanges))

        // Send ranges
        try await sender.send(ranges: firstMaxPlannedRanges)

        return .sent(ranges: firstMaxPlannedRanges)
    }

    private func planningDateRange(at date: Date) -> Range<Date> { date..<date.addingTimeInterval(planningRange) }

    private func thresholdDateRange(at date: Date) -> Range<Date> { date..<date.addingTimeInterval(threshold) }
}

public protocol ForceChargerRangeProvider {
    func forceChargingRanges(in range: Range<Date>) async throws -> [Stored<ForceChargingRange>]
}

public protocol ForceChargerRangeSender {
    func send(ranges: [Stored<ForceChargingRange>]) async throws
}

public enum ForceChargerResult: Equatable {
    case skipped(reason: ForceChargerSkipReason)
    case sent(ranges: [Stored<ForceChargingRange>])
}

public enum ForceChargerSkipReason: Equatable {
    case containsSent
    case waitForMinimumOfRanges
}
