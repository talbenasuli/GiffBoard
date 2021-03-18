//
//  GiffResponse.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 15/03/2021.
//

import Foundation

extension Giff {
    
    struct Response: Decodable {
        var data: [Data]?
        var pagination: Pagination?
    }
    
    struct Pagination: Codable {
        var count: Int?
        var offset: Int?
        var totalCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case count = "count"
            case offset = "offset"
            case totalCount = "total_count"
        }
    }
    
    struct Data: Codable {
        let type, id: String?
        let url: String?
        let slug: String?
        let bitlyGIFURL, bitlyURL: String?
        let embedURL: String?
        let username, source, title, rating: String?
        let contentURL, sourceTLD, sourcePostURL: String?
        let isSticker: Int?
        let importDatetime, trendingDatetime: String?
        let images: Images?
        
        enum CodingKeys: String, CodingKey {
            case type, id, url, slug
            case bitlyGIFURL = "bitly_gif_url"
            case bitlyURL = "bitly_url"
            case embedURL = "embed_url"
            case username, source, title, rating
            case contentURL = "content_url"
            case sourceTLD = "source_tld"
            case sourcePostURL = "source_post_url"
            case isSticker = "is_sticker"
            case importDatetime = "import_datetime"
            case trendingDatetime = "trending_datetime"
            case images
        }
    }
    
    // MARK: - Images
    struct Images: Codable {
        let original: FixedHeight?
        let downsized: The480_WStill?
    }
    
    // MARK: - The480_WStill
    struct The480_WStill: Codable {
        let height, width, size: String?
        let url: String?
    }
    
    // MARK: - FixedHeight
    struct FixedHeight: Codable {
        let height, width, size: String?
        let url: String?
        let mp4Size: String?
        let mp4: String?
        let webpSize: String?
        let webp: String?
        let frames, hash: String?
        
        enum CodingKeys: String, CodingKey {
            case height, width, size, url
            case mp4Size = "mp4_size"
            case mp4
            case webpSize = "webp_size"
            case webp, frames, hash
        }
    }
}

