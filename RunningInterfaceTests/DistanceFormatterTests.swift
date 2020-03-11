//
//  DistanceFormatterTests.swift
//  RunningInterfaceTests
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import XCTest
@testable import RunningInterface

final class DistanceFormatterTests: XCTestCase {

    func testBasicCases() {
        let formatter = DistanceFormatter()
        XCTAssertEqual(formatter.textInKm(0), "0km")
        XCTAssertEqual(formatter.textInKm(11), "0km")
        XCTAssertEqual(formatter.textInKm(111), "0.1km")
        XCTAssertEqual(formatter.textInKm(151), "0.2km")
        XCTAssertEqual(formatter.textInKm(1151), "1.2km")
    }
}
