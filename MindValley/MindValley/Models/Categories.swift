//
//  Categories.swift
//  MindValley
//
//  Created by Kumar, Karthik on 01/06/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import Foundation

struct Categories: Decodable {
    var list: [Category]
    
    enum CodingKeys: String, CodingKey {
        case root = "data"
        
        enum NestedCodingKeys: String, CodingKey {
            case list = "categories"
        }
    }
}

extension Categories {
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try rootContainer.nestedContainer(keyedBy: CodingKeys.NestedCodingKeys.self, forKey: .root)
        
        
        list = try container.decode([Category].self, forKey: CodingKeys.NestedCodingKeys.list)
    }
}

struct Category: Decodable {
    var name: String
}
