//
//  PushDeviceMessageTypeSettings.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 16.10.24.
//

public struct PushDeviceMessageTypeSettings: Codable, Equatable, Hashable {
    public var isEnabled: Bool

    public init(isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
}
