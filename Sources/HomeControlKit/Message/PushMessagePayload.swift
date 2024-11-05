//
//  PushMessagePayload.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 05.11.24.
//

public struct PushMessagePayload: Codable, Sendable {
    public var messageType: MessageType

    public init(messageType: MessageType) {
        self.messageType = messageType
    }
}
