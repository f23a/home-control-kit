//
//  WebSocketDidSaveSettingMessage.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 05.10.24.
//

import Foundation

public struct WebSocketDidSaveSettingMessage: WebSocketMessage {
    public var identifier: String { "WebSocketDidSaveSettingMessage" }
    public var content: Content

    public init(setting: Setting) {
        self.content = .init(setting: setting)
    }

    public struct Content: Codable {
        public let setting: Setting
    }
}
