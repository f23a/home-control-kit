//
//  Job.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 12.10.24.
//

import Foundation

open class Job {
    public let id: UUID
    private let maxAge: TimeInterval
    public private(set) var lastRun: Date?

    public init(maxAge: TimeInterval) {
        self.id = UUID()
        self.maxAge = maxAge
    }

    open func run() async {
        fatalError("Override")
    }

    public func runIfNeeded(at date: Date) async {
        guard needsRun(at: date) else { return }
        await run()
        lastRun = Date()
    }

    private func needsRun(at date: Date) -> Bool {
        guard let lastRun else { return true }
        return lastRun.addingTimeInterval(maxAge) < date
    }
}
