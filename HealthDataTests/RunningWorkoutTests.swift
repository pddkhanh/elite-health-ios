//
//  RunningWorkoutTests.swift
//  HealthDataTests
//
//  Created by Khanh Pham on 8/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import XCTest
@testable import HealthData

final class RunningWorkoutTests: XCTestCase {
    func testInit() {
        let duration: TimeInterval = 5000
        let endDate = Date(timeIntervalSinceNow: -1_000)
        let startDate = endDate.addingTimeInterval(-duration)
        let distance: Double = 5121
        let model = RunningWorkout(startDate: startDate, endDate: endDate, duration: duration, totalDistance: distance)
        XCTAssertEqual(model.startDate, startDate)
        XCTAssertEqual(model.endDate, endDate)
        XCTAssertEqual(model.duration, duration)
        XCTAssertEqual(model.totalDistance, distance)
    }
}
