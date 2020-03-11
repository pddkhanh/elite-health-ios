//
//  HealthKitManaging.swift
//  HealthData
//
//  Created by Khanh Pham on 8/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation
import Combine

public protocol HealthKitManaging {
    var isHealthDataAvailable: Bool { get }
    func loadRunningWorkouts(from date: Date) -> Future<[RunningWorkout], Error>
    func requestReadWorkoutsPermission() -> Future<Bool, Error>
}
