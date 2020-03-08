//
//  HealthKitDataReader.swift
//  HealthData
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation
import HealthKit
import Combine

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

    init(workout: HKWorkout) {
        let distance = workout.totalDistance?.doubleValue(for: HKUnit.meter()) ?? 0
        self.init(startDate: workout.startDate, endDate: workout.endDate, duration: workout.duration, totalDistance: distance)
    }
}

public protocol HealthKitManaging {
    func isHealthDataAvailable() -> Bool
    func loadRunningWorkouts(from date: Date) -> Future<[RunningWorkout], Error>
    func requestReadWorkoutsPermission() -> Future<Bool, Error>
}

public final class HealthKitManager: HealthKitManaging {

    private let healthStore = HKHealthStore()

    public init() {}

    public func isHealthDataAvailable() -> Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    public func requestReadWorkoutsPermission() -> Future<Bool, Error> {
        return Future { promise in
            let allTypes = Set([
                HKObjectType.workoutType(),
                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
                ])
            self.healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(success))
                }
            }
        }
    }

    public func loadRunningWorkouts(from date: Date) -> Future<[RunningWorkout], Error> {
        let runningPredicate = HKQuery.predicateForWorkouts(with: .running)
        let datePredicate = HKQuery.predicateForSamples(withStart: date, end: nil, options: [])
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [runningPredicate, datePredicate])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

        return Future { promise in
            let query = HKSampleQuery(
              sampleType: .workoutType(),
              predicate: compound,
              limit: 0,
              sortDescriptors: [sortDescriptor]) { (_, samples, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let workouts = samples as? [HKWorkout] {
                    promise(.success(workouts.map(RunningWorkout.init(workout:))))
                } else {
                    promise(.success([]))
                }
              }
            self.healthStore.execute(query)
        }
    }
}
