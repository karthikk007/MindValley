//
//  DataManagerEventsObservable.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

protocol DataManagerEventsObservable {
    func subscribeToDataManagerEvents(for events: [AppNotifications])
    func unsubscribeToDataManagerEvents()
    func didUpdateCategories(notification: Notification)
    func didUpdateEpisodes(notification: Notification)
    func didUpdateChannels(notification: Notification)
    func fetchCompelete(notification: Notification)
}

extension DataManagerEventsObservable where Self: UIViewController {
    func subscribeToDataManagerEvents(for events: [AppNotifications]) {
        
        for event in events {
            NotificationCenter.default.addObserver(forName: .name(for: event), object: nil, queue: nil) { [weak self] (notification) in
                guard let self = self else { return }
                
                switch event {
                case .categoriesFetched:
                    self.didUpdateCategories(notification: notification)
                case .episodesFetched:
                    self.didUpdateEpisodes(notification: notification)
                case .channelsFetched:
                    self.didUpdateChannels(notification: notification)
                case .fetchComplete:
                    self.fetchCompelete(notification: notification)
                }
            }
        }
    }
    
    func unsubscribeToDataManagerEvents() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func didUpdateCategories(notification: Notification) {
        
    }
    
    func didUpdateEpisodes(notification: Notification) {
        
    }
    
    func didUpdateChannels(notification: Notification) {
        
    }
}
