//
//  AppNotifications.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

enum AppNotifications: String {
    case episodesFetched
    case categoriesFetched
    case channelsFetched
    case fetchComplete
}

extension AppNotifications {
    var value: String {
        return self.rawValue
    }
}
