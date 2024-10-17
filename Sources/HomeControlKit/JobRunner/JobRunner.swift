//
//  JobRunner.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 12.10.24.
//

import Foundation

public class JobRunner {
    private var updateTimer: Timer!
    private var jobs: [Job] = []
    private var isRunning: Bool = false

    public init() {
        updateTimer = .scheduledTimer(
            timeInterval: 0.2,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(updateTimer!, forMode: .common)
    }

    public func append(job: Job) {
        jobs.append(job)
    }

    @objc private func fireTimer() {
        guard !isRunning else { return }
        isRunning = true
        Task.detached {
            await self.runJobs()
            self.isRunning = false
        }
    }

    private func runJobs() async {
        for job in jobs {
            await job.runIfNeeded(at: Date())
        }
    }
}
