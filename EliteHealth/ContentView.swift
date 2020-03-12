//
//  ContentView.swift
//  EliteHealth
//
//  Created by Khanh Pham on 11/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import SwiftUI
import RunningInterface

struct ContentView: View {

    var body: some View {
        NavigationView {
            RunningFactory.createSummaryView()
            .navigationBarTitle("Running")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
