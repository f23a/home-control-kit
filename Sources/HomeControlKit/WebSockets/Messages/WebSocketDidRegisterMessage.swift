//
//  WebSocketDidRegisterMessage.swift.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 21.09.24.
//

import Foundation

public struct WebSocketDidRegisterMessage: WebSocketMessage {
    public var identifier: String { "WebSocketDidRegisterMessage" }
    public var content: Content

    public init(id: UUID) {
        self.content = .init(id: id)
    }

    public struct Content: Codable {
        public let id: UUID
    }
}
