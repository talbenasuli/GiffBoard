//
//  NetworkManager.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import Foundation

enum Network { }

enum NetworkError: Error {
    case requestFailed
    case httpError
    case parsing
}

protocol NetworkManagerType {
    func dispatch<Response: Decodable, Body: Encodable>(request: Network.Request<Response, Body>, completion: @escaping (Result<Response, NetworkError>) -> Void)
}

extension Network {
    
    final class Manager: NetworkManagerType {
        
        let session: URLSession
        let decoder: DecoderType
        
        init(session: URLSession = .shared,
             decoder: DecoderType = Network.JsonDecoder()) {
            self.session = session
            self.decoder = decoder
        }
        
        func dispatch<Response, Body>(request: Network.Request<Response, Body>, completion: @escaping (Result<Response, NetworkError>) -> Void) where Response : Decodable, Body : Encodable {
            
            guard let urlRequest = request.urlRequest else {
                completion(.failure(.requestFailed))
                return
            }
            
            session.dataTask(with: urlRequest) { (data, response, error) in

                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else {
                    completion(.failure(.httpError))
                    return
                }
                
                guard (200 ... 299) ~= response.statusCode else {
                    completion(.failure(.httpError))
                    return
                }
                
                do {
                    let decoded = try self.decoder.decode(Response.self, from: data)
                    completion(.success(decoded))
                } catch let error {
                    print(error)
                    completion(.failure(.parsing))
                }
                
            }.resume()
        }
    }
}


