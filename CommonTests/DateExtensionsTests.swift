//
//  DateExtensionsTests.swift
//  CommonTests
//
//  Created by Khanh Pham on 11/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import XCTest
@testable import Common

final class DateExtensionsTests: XCTestCase {
    func testFirstDayOfXXX() {
        let date = Date(timeIntervalSince1970: 1583889887) // Wednesday, 11 March 2020 01:24:47

        let calendar = Calendar.current
        let firstDayOfYear = calendar.date(from: DateComponents(calendar: calendar, year: 2020, month: 1, day: 1))!
        let firstDayOfMonth = calendar.date(from: DateComponents(calendar: calendar, year: 2020, month: 3, day: 1))!
        let firstDayOfWeek = calendar.date(from: DateComponents(calendar: calendar, year: 2020, month: 3, day: 8))!
        XCTAssertEqual(date.firstDayOfYear, firstDayOfYear)
        XCTAssertEqual(date.firstDayOfMonth, firstDayOfMonth)
        XCTAssertEqual(date.firstDayOfWeek, firstDayOfWeek)
    }

    func testFirstDayOfWeekExtended() {
        let date = Date(timeIntervalSince1970: 1577898120) // Wednesday, 1 January 2020 17:02:00

        let calendar = Calendar.current
        let firstDayOfWeek = calendar.date(from: DateComponents(calendar: calendar, year: 2019, month: 12, day: 29))!
        XCTAssertEqual(date.firstDayOfWeek, firstDayOfWeek)
    }
}
