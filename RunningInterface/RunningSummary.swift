//
//  RunningSummary.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation

/**
 Sumary for running data.

 - Note: Distances are in meters.
 */
struct RunningSummary {

    var date: Date

    var dayDistance: Double
    var weekDistance: Double
    var monthDistance: Double
    var yearDistance: Double

    init(date: Date,
         dayDistance: Double,
         weekDistance: Double,
         monthDistance: Double,
         yearDistance: Double) {
        self.date = date
        self.dayDistance = dayDistance
        self.weekDistance = weekDistance
        self.monthDistance = monthDistance
        self.yearDistance = yearDistance
    }

    static let empty = RunningSummary(date: Date(timeIntervalSince1970: 0), dayDistance: 0, weekDistance: 0, monthDistance: 0, yearDistance: 0)
}
