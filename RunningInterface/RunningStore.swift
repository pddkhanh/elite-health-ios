//
//  RunningStore.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import HealthData
import Common

final class RunningStore: ObservableObject {
    @Published var summary: RunningSummary = .empty
    @Published var isHealthDataAvailable = true

    let healthKitManager: HealthKitManaging
    private var cancellables = Set<AnyCancellable>()

    init(healthKitManager: HealthKitManaging) {
        self.healthKitManager = healthKitManager
    }

    func fetch() {
        guard healthKitManager.isHealthDataAvailable() else {
            isHealthDataAvailable = false
            summary = .empty
            return
        }
        isHealthDataAvailable = true

        let fromDate = Date().firstDayOfYear
        healthKitManager.loadRunningWorkouts(from: fromDate)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error load workouts: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] workouts in
                guard let self = self else { return }
                self.summary = self.parseFetchWorkoutResult(workouts)
            })
            .store(in: &cancellables)

    }

    private func parseFetchWorkoutResult(_ workouts: [RunningWorkout]) -> RunningSummary {
        let date = Date()
        var yearDistance = 0.0, monthDistance = 0.0, weekDistance = 0.0, dayDistance = 0.0
        let startOfDay = date.startOfDay
        let startOfYear = date.firstDayOfYear
        let startOfMonth = date.firstDayOfMonth
        let startOfWeek = date.firstDayOfWeek.addingTimeInterval(86400)
        workouts.forEach { workout in
            if workout.endDate > startOfDay {
                dayDistance += workout.totalDistance
            }
            if workout.endDate > startOfYear {
                yearDistance += workout.totalDistance
            }
            if workout.endDate > startOfMonth {
                monthDistance += workout.totalDistance
            }
            if workout.endDate > startOfWeek {
                weekDistance += workout.totalDistance
            }
        }
        return RunningSummary(
            date: date,
            dayDistance: dayDistance,
            weekDistance: weekDistance,
            monthDistance: monthDistance,
            yearDistance: yearDistance
        )
    }
}


