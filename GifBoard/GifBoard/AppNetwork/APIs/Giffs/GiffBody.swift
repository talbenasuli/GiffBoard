//
//  GiffBody.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 15/03/2021.
//

import Foundation

enum Giff { }

extension Giff {
    
    enum Rating: String, Codable {
        case verySafe = "g"
        case safe = "pg"
        case notCheckedAtAll = "r"
    }
    
    enum Language: String, Codable {
        case heb
        case en
    }
}

extension Giff {
    struct Body: Encodable {
        var apiKey: String = "TbalhqAYtccJ8gS2UgBy4D2CrfBlMrQ0"
        var query: String
        var limit: Int
        var offset: Int
        var rating: Giff.Rating = .safe
        var language: Giff.Language = .en
        
        enum CodingKeys: String, CodingKey {
            case apiKey = "api_key"
            case query = "q"
            case limit = "limit"
            case offset = "offset"
            case rating = "rating"
            case language = "language"
        }
    }
}
