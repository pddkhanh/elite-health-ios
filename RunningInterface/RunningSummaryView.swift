//
//  RunningSummaryView.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct RunningSummaryView: View {

    @EnvironmentObject var store: RunningStore

    private let formatter = DistanceFormatter()
    private let paceFormatter = PaceFormatter()

    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        Group {
            if store.availability == .notDetermined {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
            else if store.availability == .healthDataNotAvailable {
                Text("Health data is unavailable on this device")
            } else if store.availability == .permissionDenied {
                Button("Permission denied. Enable it to load your workouts summary") {
                    self.openSetting()
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        Text("Today").font(.headline)
                        Spacer(minLength: 8)
                        Text("Distance: \(formatter.textInKm(store.summary.day.distance)). Pace: \(paceFormatter.textInMinutesPerKm(store.summary.day.paceSecondPerKm))")
                    }.padding()
                    VStack(alignment: .leading) {
                        Text("This week").font(.headline)
                        Spacer(minLength: 8)
                        Text("Distance: \(formatter.textInKm(store.summary.week.distance)). Pace: \(paceFormatter.textInMinutesPerKm(store.summary.week.paceSecondPerKm))")
                    }.padding()
                    VStack(alignment: .leading) {
                        Text("This month").font(.headline)
                        Spacer(minLength: 8)
                        Text("Distance: \(formatter.textInKm(store.summary.month.distance)). Pace: \(paceFormatter.textInMinutesPerKm(store.summary.month.paceSecondPerKm))")
                    }.padding()
                    VStack(alignment: .leading) {
                        Text("This year").font(.headline)
                        Spacer(minLength: 8)
                        Text("Distance: \(formatter.textInKm(store.summary.year.distance)). Pace: \(paceFormatter.textInMinutesPerKm(store.summary.year.paceSecondPerKm))")
                    }.padding()
                    VStack(alignment: .leading) {
                        Text("Last year").font(.headline)
                        Spacer(minLength: 8)
                        Text("Distance: \(formatter.textInKm(store.summary.lastYear.distance)). Pace: \(paceFormatter.textInMinutesPerKm(store.summary.lastYear.paceSecondPerKm))")
                    }.padding()
                }
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
