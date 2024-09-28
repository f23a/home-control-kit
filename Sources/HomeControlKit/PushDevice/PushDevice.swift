//
//  PushDevice.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 27.09.24.
//

public struct PushDevice: Codable {
    public var deviceToken: String

    public init(deviceToken: String) {
        self.deviceToken = deviceToken
    }
}
