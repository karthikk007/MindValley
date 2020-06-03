//
//  Episode.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

struct Episodes: Decodable {
    var list: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case root = "data"
        
        enum NestedCodingKeys: String, CodingKey {
            case list = "media"
        }
    }
}

extension Episodes {
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try rootContainer.nestedContainer(keyedBy: CodingKeys.NestedCodingKeys.self, forKey: .root)
        
        
        list = try container.decode([Episode].self, forKey: CodingKeys.NestedCodingKeys.list)
    }
}

struct Episode: Codable {
    var type: String?
    var title: String?
    var assetUrl: String?
    var channelTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case title
        case assetUrl = "coverAsset"
        case channelTitle = "channel"
        
        enum ChannelCodingKeys: String, CodingKey {
            case title
        }
        
        enum AssetCodingKeys: String, CodingKey {
            case url
        }
    }
}

extension Episode {
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try keyedContainer.decode(String.self, forKey: .type)
        
        let channelContainer = try keyedContainer.nestedContainer(keyedBy: CodingKeys.ChannelCodingKeys.self, forKey: .channelTitle)
        
        channelTitle = try channelContainer.decode(String.self, forKey: .title)
        
        let assetContainer = try keyedContainer.nestedContainer(keyedBy: CodingKeys.AssetCodingKeys.self, forKey: .assetUrl)
        
        assetUrl = try assetContainer.decode(String.self, forKey: .url)
        
        title = try keyedContainer.decode(String.self, forKey: .title)
    }
}
