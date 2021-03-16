//
//  NetworkRequest.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import Foundation

extension Network {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    final class Request<Response: Decodable, Body: Encodable> {
        
        let path: String
        let method: Method
        let timeoutInterval: TimeInterval
       
        var body: Body?
        var headers = [(value: String, header: String)]()
        
        init(path: String,
             method: Method,
             timeoutInterval: TimeInterval = 5) {
            self.path = path
            self.method = method
            self.timeoutInterval = timeoutInterval
        }
        
        func addHeader(value: String, for httpHeader: String) -> Self {
            headers.append((value: value, header: httpHeader))
            return self
        }
        
        func addBody(_ body: Body) -> Self {
            self.body = body
            return self
        }
    }
}

extension Network.Request {
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: path) else { return nil }
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue

        do {
            if let body = body {
                let encoded = try JSONEncoder().encode(body)
                
                switch method {
                case .get:
                    if let json = try JSONSerialization.jsonObject(with: encoded, options: []) as? [String: Any] {
                        let urlComp = NSURLComponents(string: path)
                        let items = json.compactMap { (key, value) -> URLQueryItem? in
                            return URLQueryItem(name: key, value: String(describing: value))
                        }
                        
                        if !items.isEmpty {
                            urlComp?.queryItems = items
                        }
                        request = URLRequest(url: urlComp!.url!, timeoutInterval: timeoutInterval)
                        request.httpMethod = method.rawValue
                    }
                    
                case .post:
                    request.httpBody = encoded
                }
            }
         
        } catch {}
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.header)
        }
        return request
    }
}
