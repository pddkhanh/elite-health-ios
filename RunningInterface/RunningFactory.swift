//
//  RunningFactory.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import SwiftUI
import CoreData
import HealthData

public struct RunningFactory {
    public static func createSummaryView(context: NSManagedObjectContext) -> some View {
        RunningSummaryView()
            .environmentObject(RunningStore(healthKitManager: HealthKitManager()))
    }
}
