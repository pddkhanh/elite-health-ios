//
//  RunningSummaryView.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import SwiftUI

struct RunningSummaryView: View {

    @EnvironmentObject var store: RunningStore

    private let formatter = DistanceFormatter()

    var body: some View {
        Group {
            if store.availability == .notDetermined {
                Text("...")
            }
            else if store.availability == .healthDataNotAvailable {
                Text("HealthKit is not available on this device")
            } else if store.availability == .permissionDenied {
                Button("Permission denied. Enable it to load your workouts summary") {
                    self.openSetting()
                }
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Today: \(formatter.textInKm(store.summary.dayDistance))")
                    Text("This week: \(formatter.textInKm(store.summary.weekDistance))")
                    Text("This month: \(formatter.textInKm(store.summary.monthDistance))")
                    Text("This year: \(formatter.textInKm(store.summary.yearDistance))")
                }
                .font(.title)
            }
        }
        .onAppear(perform: loadData)
        .onTapGesture(perform: loadData)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification), perform: { _ in
            self.loadData()
        })
    }

    private func loadData() {
        print("RunningSummaryView: loadData")
        store.fetch()
    }

    private func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}

#if DEBUG

import HealthData

struct RunningSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RunningSummaryView()
            .environmentObject(RunningStore(healthKitManager: HealthKitManager()))
    }
}

#endif
