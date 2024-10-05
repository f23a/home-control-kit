//
//  Setting.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 05.10.24.
//

public struct Setting: Codable {
    public var id: String

    public init(id: String) {
        self.id = id
    }
}
