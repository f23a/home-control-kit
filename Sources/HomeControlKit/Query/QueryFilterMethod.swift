//
//  QueryFilterMethod.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.11.24.
//

public enum QueryFilterMethod: String, Codable {
    case equal
    case notEqual
    case greaterThan
    case greaterThanOrEqual
    case lessThan
    case lessThanOrEqual
}
