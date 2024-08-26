//
//  SettingsOptionsViewModel.swift
//  MessangerSwiftUI
//
//  Created by white4ocolate on 09.08.2024.
//

import Foundation
import SwiftUI

enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable {
    case activeStatus
    case accessibility
    case privacy
    case notifications
    
    var title: String {
        switch self {
        case .activeStatus:
            return "Active status"
        case .accessibility:
            return "Accessibility"
        case .privacy:
            return "Privacy"
        case .notifications:
            return "Notifications"
        }
    }
    
    var imageName: String {
        switch self {
        case .activeStatus:
            return "message.badge.circle.fill"
        case .accessibility:
            return "person.circle.fill"
        case .privacy:
            return "lock.circle.fill"
        case .notifications:
            return "bell.circle.fill"
        }
    }
    
    var imageBackgroundColor: Color {
        switch self {
        case .activeStatus:
            return Color(.systemGray2)
        case .accessibility:
            return Color(.systemGray2)
        case .privacy:
            return Color(.systemGray2)
        case .notifications:
            return Color(.systemGray2)
        }
    }
    
    var id: Int { return self.rawValue }
}
