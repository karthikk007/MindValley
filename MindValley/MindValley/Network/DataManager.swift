//
//  DataManager.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

class DataManager {
    static let sharedInstance = DataManager()
    
    private let dispatchGroup = DispatchGroup()
    
    private(set) var episodes: Episodes? {
        didSet {
            NotificationCenter.default.post(name: .name(for: .episodesFetched), object: nil)
        }
    }
    
    private(set) var categories: Categories? {
        didSet {
            NotificationCenter.default.post(name: .name(for: .categoriesFetched), object: nil)
        }
    }
    
    private(set) var channels: Channels? {
        didSet {
            NotificationCenter.default.post(name: .name(for: .channelsFetched), object: nil)
        }
    }
    
    private func fetchData() {
        getEpisodes()
        getCategories()
        getChannels()
        
        dispatchGroup.notify(queue: .main) {
            NotificationCenter.default.post(name: .name(for: .fetchComplete), object: nil)
        }
    }
    
    private func getEpisodes() {
        dispatchGroup.enter()
        ApiService.sharedInstance.fetchEpisodes { (episodes) in
            self.episodes = episodes
            self.dispatchGroup.leave()
        }
    }
    
    private func getCategories() {
        dispatchGroup.enter()
        ApiService.sharedInstance.fetchCategories { (categories) in
            self.categories = categories
            self.dispatchGroup.leave()
        }
    }
    
    private func getChannels() {
        dispatchGroup.enter()
        ApiService.sharedInstance.fetchChannels { (channels) in
            self.channels = channels
            self.dispatchGroup.leave()
        }
    }

    func refreshData() {
        fetchData()
    }
}
