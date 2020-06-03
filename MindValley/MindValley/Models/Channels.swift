//
//  Channels.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

struct Channels: Decodable {
    var list: [Channel]
    
    enum CodingKeys: String, CodingKey {
        case root = "data"
        
        enum NestedCodingKeys: String, CodingKey {
            case list = "channels"
        }
    }
}

extension Channels {
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try rootContainer.nestedContainer(keyedBy: CodingKeys.NestedCodingKeys.self, forKey: .root)
        
        
        list = try container.decode([Channel].self, forKey: CodingKeys.NestedCodingKeys.list)
    }
}

struct Channel: Decodable {
    var title: String?
    var seriesList: [Series]?
    var mediaCount: Int
    var latestMediaList: [Media]?
    var id: String?
    var assetUrl: String?
    var thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case mediaCount
        case latestMediaList = "latestMedia"
        case id
        case seriesList = "series"
        case assetUrl = "coverAsset"
        case thumbnailUrl = "iconAsset"
        
        enum AssetCodingKeys: String, CodingKey {
            case url
        }
        
        enum ThumbnailCodingKeys: String, CodingKey {
            case thumbnailUrl
        }
        
        enum MediaCodingKeys: String, CodingKey {
            case latestMedia
        }
    }
}

extension Channel {
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        latestMediaList = try keyedContainer.decode([Media].self, forKey: CodingKeys.latestMediaList)
        
        if let assetContainer = try? keyedContainer.nestedContainer(keyedBy: CodingKeys.AssetCodingKeys.self, forKey: .assetUrl) {
            assetUrl = try assetContainer.decode(String.self, forKey: .url)
        }
        
        if let thumbnailContainer = try? keyedContainer.nestedContainer(keyedBy: CodingKeys.ThumbnailCodingKeys.self, forKey: .thumbnailUrl) {
            thumbnailUrl = try? thumbnailContainer.decode(String.self, forKey: .thumbnailUrl)
        }
        
        seriesList = try keyedContainer.decode([Series].self, forKey: .seriesList)

        title = try keyedContainer.decode(String.self, forKey: .title)
        mediaCount = try keyedContainer.decode(Int.self, forKey: .mediaCount)
    }
}

