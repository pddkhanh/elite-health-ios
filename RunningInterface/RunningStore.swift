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

final class RunningStore: ObservableObject {
    @Published var summary: RunningSummary = .empty

    func fetch() {

    }
}
