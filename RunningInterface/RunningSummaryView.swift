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
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Day: \(formatter.textInKm(store.summary.dayDistance))")
                Text("Week: \(formatter.textInKm(store.summary.weekDistance))")
                Text("Month: \(formatter.textInKm(store.summary.monthDistance))")
                Text("Year: \(formatter.textInKm(store.summary.yearDistance))")
            }
            .font(.title)
            .navigationBarTitle("Running")
        }.onAppear(perform: loadData)
    }

    private func loadData() {
        store.fetch()
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
