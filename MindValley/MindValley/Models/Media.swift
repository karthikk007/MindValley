//
//  Media.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

struct Media: Decodable {
    var type: String?
    var title: String?
    var assetUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case assetUrl = "coverAsset"
        case type
        
        enum AssetCodingKeys: String, CodingKey {
            case url
        }
    }
}

extension Media {
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        let assetContainer = try keyedContainer.nestedContainer(keyedBy: CodingKeys.AssetCodingKeys.self, forKey: .assetUrl)
        
        assetUrl = try assetContainer.decode(String.self, forKey: .url)
        
        title = try keyedContainer.decode(String.self, forKey: .title)
        type = try keyedContainer.decode(String.self, forKey: .type)
    }
}
