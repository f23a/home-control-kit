//
//  ForceChargerTests.swift
//  home-control-kit
//
//  Created by Christoph Pageler on 12.10.24.
//

//import XCTest
//@testable import HomeControlKit
//
//final class ForceChargerTests: XCTestCase {
//    struct TestProvider: ForceChargerRangeProvider {
//        var closure: (Range<Date>) async throws -> [Stored<ForceChargingRange>]
//        func forceChargingRanges(in range: Range<Date>) async throws -> [Stored<ForceChargingRange>] {
//            try await closure(range)
//        }
//    }
//
//    struct TestSender: ForceChargerRangeSender {
//        var closure: ([Stored<ForceChargingRange>]) async throws -> Void
//        func send(ranges: [Stored<ForceChargingRange>]) async throws {
//            try await closure(ranges)
//        }
//    }
//
//    func testCorrectRangeFetch() async throws {
//        let date = Date()
//        let provider = TestProvider { range in
//            XCTAssertEqual(range.lowerBound, date)
//            XCTAssertEqual(range.upperBound, date.addingTimeInterval(24.hours))
//            return []
//        }
//        let sender = TestSender { ranges in
//            XCTFail("Should not be called")
//        }
//        let forceCharger = ForceCharger(provider: provider, sender: sender)
//        let result = try await forceCharger.execute(at: date)
//        XCTAssertEqual(result, .skipped(reason: .waitForMinimumOfRanges))
//    }
//
//    func testOneInRange() async throws {
//        let date = Date()
//        let provider = TestProvider { _ in
//            return [
//                .init(
//                    id: .init(),
//                    value: .init(
//                        startsAt: date.addingTimeInterval(10.hours),
//                        endsAt: date.addingTimeInterval(11.hours),
//                        targetStateOfCharge: 1,
//                        state: .planned,
//                        source: .user
//                    ),
//                    createdAt: Date()
//                )
//            ]
//        }
//        let sender = TestSender { ranges in
//            XCTFail("Should not be called")
//        }
//        let forceCharger = ForceCharger(provider: provider, sender: sender)
//        let result = try await forceCharger.execute(at: date)
//        XCTAssertEqual(result, .skipped(reason: .waitForMinimumOfRanges))
//    }
//
//    func testOneInThreshold() async throws {
//        let date = Date()
//        let id = UUID()
//        let provider = TestProvider { _ in
//            return [
//                .init(
//                    id: id,
//                    value: .init(
//                        startsAt: date.addingTimeInterval(1.hours),
//                        endsAt: date.addingTimeInterval(2.hours),
//                        targetStateOfCharge: 1,
//                        state: .planned,
//                        source: .user
//                    ),
//                    createdAt: Date()
//                )
//            ]
//        }
//        let sender = TestSender { ranges in
//            XCTAssertEqual(ranges.count, 1)
//            XCTAssertEqual(ranges.first?.id, id)
//        }
//        let forceCharger = ForceCharger(provider: provider, sender: sender)
//        let result = try await forceCharger.execute(at: date)
//
//        switch result {
//        case .skipped:
//            XCTFail()
//        case let .sent(ranges):
//            XCTAssertEqual(ranges.count, 1)
//            XCTAssertEqual(ranges.first?.id, id)
//        }
//    }
//
//    func testTwoInRange() async throws {
//        let date = Date()
//        let id1 = UUID()
//        let id2 = UUID()
//        let provider = TestProvider { _ in
//            return [
//                .init(
//                    id: id1,
//                    value: .init(
//                        startsAt: date.addingTimeInterval(10.hours),
//                        endsAt: date.addingTimeInterval(11.hours),
//                        targetStateOfCharge: 1,
//                        state: .planned,
//                        source: .user
//                    ),
//                    createdAt: Date()
//                ),
//                .init(
//                    id: id2,
//                    value: .init(
//                        startsAt: date.addingTimeInterval(22.hours),
//                        endsAt: date.addingTimeInterval(23.hours),
//                        targetStateOfCharge: 1,
//                        state: .planned,
//                        source: .user
//                    ),
//                    createdAt: Date()
//                )
//            ]
//        }
//        let sender = TestSender { ranges in
//            XCTAssertEqual(ranges.count, 2)
//            XCTAssertEqual(ranges[0].id, id1)
//            XCTAssertEqual(ranges[1].id, id2)
//        }
//        let forceCharger = ForceCharger(provider: provider, sender: sender)
//        let result = try await forceCharger.execute(at: date)
//
//        switch result {
//        case .skipped:
//            XCTFail()
//        case let .sent(ranges):
//            XCTAssertEqual(ranges.count, 2)
//            XCTAssertEqual(ranges[0].id, id1)
//            XCTAssertEqual(ranges[1].id, id2)
//        }
//    }
//
//    func testTwoInRangeAndSentInRange() async throws {
//        let date = Date()
//        let provider = TestProvider { _ in
//            return [
//                .init(
//                    id: .init(),
//                    value: .init(
//                        startsAt: date.addingTimeInterval(1.hours),
//                        endsAt: date.addingTimeInterval(2.hours),
//                        targetStateOfCharge: 1,
//                        state: .sent,
//                        source: .user
//                    ),
//                    createdAt: Date()
//                ),
//                .init(
//                    id: .init(),
//                    value: .init(
//                        startsAt: date.addingTimeInterval(10.hours),
//                        endsAt: date.addingTimeInterval(11.hours),
//                        targetStateOfCharge: 1,
//                        state: .planned,
//                        source: .user
//                    ),
//                    createdAt: Date()
//                ),
//                .init(
//                    id: .init(),
//                    value: .init(
//                        startsAt: date.addingTimeInterval(22.hours),
//                        endsAt: date.addingTimeInterval(23.hours),
//                        targetStateOfCharge: 1,
//                        state: .planned,
//                        source: .user
//                    ),
//                    createdAt: Date()
//                )
//            ]
//        }
//        let sender = TestSender { ranges in
//            XCTFail("Should not be called")
//        }
//        let forceCharger = ForceCharger(provider: provider, sender: sender)
//        let result = try await forceCharger.execute(at: date)
//        XCTAssertEqual(result, .skipped(reason: .containsSent))
//    }
//}
