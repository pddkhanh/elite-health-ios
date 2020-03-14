//
//  RunningSummary.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation

struct RunningSummaryInfo {
    var distance: Double = 0
    var paceSecondPerKm: TimeInterval = 0

    static let empty = RunningSummaryInfo()
}

/**
 Sumary for running data.

 - Note: Distances are in meters.
 */
struct RunningSummary {

    var date: Date

    var day: RunningSummaryInfo = .empty
    var week: RunningSummaryInfo = .empty
    var month: RunningSummaryInfo = .empty
    var year: RunningSummaryInfo = .empty
    var lastYear: RunningSummaryInfo = .empty

    static let empty = RunningSummary(date: Date(timeIntervalSince1970: 0))
}
