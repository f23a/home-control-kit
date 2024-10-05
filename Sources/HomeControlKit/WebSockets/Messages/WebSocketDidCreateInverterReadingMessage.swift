//
//  WebSocketDidCreateInverterReadingMessage.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 21.09.24.
//

import Foundation

public struct WebSocketDidCreateInverterReadingMessage: WebSocketMessage {
    public var identifier: String { "WebSocketDidCreateInverterReadingMessage" }
    public var content: Content

    public init(inverterReading: StoredInverterReading) {
        self.content = .init(inverterReading: inverterReading)
    }

    public struct Content: Codable {
        public let inverterReading: StoredInverterReading
    }
}
