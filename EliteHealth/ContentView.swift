//
//  ContentView.swift
//  EliteHealth
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Day")
                Text("Week")
                Text("Month")
                Text("Year")
            }.font(.title)
            .navigationBarTitle("Running")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
