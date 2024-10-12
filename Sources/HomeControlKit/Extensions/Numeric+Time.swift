//
//  Numeric+Time.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 11.10.24.
//

import Foundation

public extension Numeric {
    var minutes: Self { self * 60 }
    var hours: Self { minutes * 60 }
    var days: Self { hours * 24 }
}
