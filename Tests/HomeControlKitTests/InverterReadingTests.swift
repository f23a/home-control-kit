//
//  InverterReadingTests.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 08.10.24.
//

import XCTest
@testable import HomeControlKit

final class InverterReadingTests: XCTestCase {
    func testFormatted() throws {
        XCTAssertEqual(InverterReading.sample(batteryLevel: 0.5).formatted(\.batteryLevel), "50 %")
        XCTAssertEqual(InverterReading.sample(solarToLoad: 5500).formatted(\.solarToLoad), "5.500 W")
        XCTAssertEqual(InverterReading.sample(solarToLoad: 5500).formatted(\.solarToLoad, options: [.short]), "5,5 kW")
        XCTAssertEqual(InverterReading.sample(solarToLoad: 0).formatted(\.solarToLoad), "0 W")
        XCTAssertEqual(InverterReading.sample(solarToLoad: 0).formatted(\.solarToLoad, options: [.short]), "0 kW")
        XCTAssertEqual(InverterReading.sample(solarToLoad: 500).formatted(\.solarToLoad), "500 W")
        XCTAssertEqual(InverterReading.sample(solarToLoad: 500).formatted(\.solarToLoad, options: [.short]), "0,5 kW")
    }
}
