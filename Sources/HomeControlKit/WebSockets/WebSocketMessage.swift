//
//  WebSocketMessage.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 21.09.24.
//

import Foundation

public protocol WebSocketMessage: Codable {
    associatedtype Content: Codable

    var identifier: String { get }
    var content: Content { get set }
}
