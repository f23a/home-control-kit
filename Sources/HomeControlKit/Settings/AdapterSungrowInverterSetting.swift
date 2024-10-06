//
//  AdapterSungrowInverterSetting.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 03.10.24.
//

import Foundation

public struct AdapterSungrowInverterSetting: Codable {
    public var updateTimerInterval: TimeInterval

    public init(updateTimerInterval: TimeInterval) {
        self.updateTimerInterval = updateTimerInterval
    }
}
