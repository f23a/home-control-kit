//
//  Message.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 16.10.24.
//

public struct Message: Codable, Equatable, Hashable {
    public var type: MessageType
    public var title: String
    public var body: String

    public init(type: MessageType, title: String, body: String) {
        self.type = type
        self.title = title
        self.body = body
    }
}
