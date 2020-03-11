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

    enum Availability {
        case notDetermined
        case healthDataNotAvailable
        case permissionDenied
        case permissionGranted
    }

    @Published var summary: RunningSummary = .empty
    @Published var availability = Availability.notDetermined

    let healthKitManager: HealthKitManaging
    private var cancellables = Set<AnyCancellable>()

    init(healthKitManager: HealthKitManaging) {
        self.healthKitManager = healthKitManager
    }

    func fetch() {
        guard healthKitManager.isHealthDataAvailable else {
            availability = .healthDataNotAvailable
            summary = .empty
            return
        }

        let fromDate = Date().firstDayOfYear
        healthKitManager.requestReadWorkoutsPermission()
            .flatMap { [unowned self] success in
                return self.healthKitManager
                    .loadRunningWorkouts(from: fromDate)
                    .receive(on: DispatchQueue.main)
            }
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error load workouts: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] workouts in
                    guard let self = self else { return }
                    self.availability = .permissionGranted
                    self.summary = self.parseFetchWorkoutResult(workouts)
                })
            .store(in: &cancellables)
    }

    private func requestPermission() {
        healthKitManager.requestReadWorkoutsPermission()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error request permission: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] success in
                guard let self = self else { return }
                print("Request health permission result: \(success)")
                if success {
                    self.fetch()
                }
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


