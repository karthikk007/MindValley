//
//  URLCacheExtension.swift
//  MindValley
//
//  Created by Kumar, Karthik on 03/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

extension URLCache {
    static func configSharedCache(directory: String? = Bundle.main.bundleIdentifier, memory: Int = 5 * 1024 * 1024, disk: Int = 0) {
        URLCache.shared = {
            let cacheDirectory = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String).appendingFormat("/\(directory ?? "cache")/" )
            return URLCache(memoryCapacity: memory, diskCapacity: disk, diskPath: cacheDirectory)
        }()
    }
}
