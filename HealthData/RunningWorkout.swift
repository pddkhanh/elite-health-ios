//
//  RunningWorkout.swift
//  HealthData
//
//  Created by Khanh Pham on 8/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation

public struct RunningWorkout {
    public var startDate: Date
    public var endDate: Date
    public var duration: TimeInterval
    public var totalDistance: Double

    public init(
        startDate: Date,
        endDate: Date,
        duration: TimeInterval,
        totalDistance: Double) {
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.totalDistance = totalDistance
    }
}

public extension RunningWorkout {
    var pacePerKm: TimeInterval { (duration / (totalDistance / 1000)) }
}
