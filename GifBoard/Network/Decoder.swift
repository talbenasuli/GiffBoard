//
//  Decoder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import Foundation

protocol DecoderType {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension Network {
    
    final class JsonDecoder: DecoderType {
        
        func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
            let decoded = try JSONDecoder().decode(type, from: data)
            return decoded
        }
    }
}
