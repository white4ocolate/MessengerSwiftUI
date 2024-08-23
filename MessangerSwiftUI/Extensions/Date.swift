//
//  Date.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 23.08.2024.
//

import Foundation

extension Date {
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }
    
    private var dayOfWeekFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        
        return formatter
    }
    
    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }
    
    private func dayOfWeekString() -> String {
        return dayOfWeekFormatter.string(from: self)
    }
    
    private func dateString() -> String {
        return dateFormatter.string(from: self)
    }
    
    func timestampString() -> String {
        if Calendar.current.isDateInToday(self) {
            return timeString()
        } else if Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear) {
            return dayOfWeekString()
        } else {
            return dateString()
        }
    }
}
