//
//  DateExtensions.swift
//  Common
//
//  Created by Khanh Pham on 11/3/20.
//  Copyright © 2020 Khanh Pham. All rights reserved.
//

import Foundation

public extension Calendar {
    static var appCalendar: Calendar {
        var cal = Calendar.current
        cal.firstWeekday = 2
        return cal
    }
}

public extension Date {
    var startOfDay: Date {
        calendar.startOfDay(for: self)
    }

    var firstDayOfYear: Date {
        let components = calendar.dateComponents([.year], from: self)
        return calendar.date(from: components)!
    }

    var firstDayPreviousYear: Date {
        return calendar.date(byAdding: .year, value: -1, to: firstDayOfYear)!
    }

    var firstDayOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }

    var firstDayOfWeek: Date {
        let components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        return calendar.date(from: components)!
    }

    private var calendar: Calendar {
        Calendar.appCalendar
    }
}
