//
//  Task+Sleep.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 12.10.24.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
    static func sleep(_ durationInSeconds: TimeInterval) async {
        try? await Task.sleep(nanoseconds: UInt64(durationInSeconds * 1_000_000_000))
    }
}
