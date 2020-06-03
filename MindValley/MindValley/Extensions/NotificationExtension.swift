//
//  NotificationExtension.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

extension Notification.Name {
    static func name(for name: String) -> Notification.Name {
        return Notification.Name(name)
    }
    
    static func name(for type: AppNotifications) -> Notification.Name {
        return Notification.Name(type.value)
    }
}
