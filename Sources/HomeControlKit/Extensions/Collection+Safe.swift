//
//  Collection+Safe.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 16.10.24.
//

public extension Collection {
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
