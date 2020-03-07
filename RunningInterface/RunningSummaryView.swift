//
//  RunningSummaryView.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import SwiftUI

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
}

struct RunningSummaryView: View {

    let summary: RunningSummary

    private let formatter = DistanceFormatter()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Day: \(formatter.textInKm(summary.dayDistance))")
            Text("Week: \(formatter.textInKm(summary.weekDistance))")
            Text("Month: \(formatter.textInKm(summary.monthDistance))")
            Text("Year: \(formatter.textInKm(summary.yearDistance))")
        }.font(.title)
    }
}

struct RunningSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RunningSummaryView(
            summary: RunningSummary(
                date: Date(),
                dayDistance: 3562,
                weekDistance: 15320,
                monthDistance: 62500,
                yearDistance: 120440
            )
        )
    }
}
