//
//  DotEnvTests.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 17.11.24.
//

import XCTest
@testable import HomeControlKit

final class DotEnvTests: XCTestCase {
    func testKeyValue() throws {
        let dotEnv = try DotEnv<[String: String]>(string: #"{"key": "value"}"#)
        XCTAssertEqual(dotEnv.get("key"), "value")
    }

    func testStruct() throws {
        struct TestStruct: Codable {
            let foo: String
        }
        let dotEnv = try DotEnv<TestStruct>(string: #"{"foo": "bar"}"#)
        XCTAssertEqual(dotEnv.content.foo, "bar")
    }
}
