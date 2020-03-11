//
//  DistanceFormatter.swift
//  RunningInterface
//
//  Created by Khanh Pham on 7/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation

struct DistanceFormatter {
    struct Internal {
        static let formatter: LengthFormatter = {
            let formatter = LengthFormatter()
            formatter.unitStyle = .short
            return formatter
        }()
    }

    func textInKm(_ meters: Double) -> String {
        let rounded = (Double(Int(meters) / 10) / 10).rounded() / 10
        return Internal.formatter.string(fromValue: rounded, unit: .kilometer)
    }
}
