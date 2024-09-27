//
//  ElectricityMeter.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 27.09.24.
//

public struct ElectricityMeter: Codable {
    public var title: String

    public init(title: String) {
        self.title = title
    }
}
