//
//  NetworkManager.swift
//  Marvel
//
//  Created by Abhishek on 09/10/23.
//

import UIKit
class NetworkManager{
    static var shared = NetworkManager()
    
    public func getRequest(param: [String: Any], url: String, completion: @escaping((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)){
        var components = URLComponents(string: url)
        let hashAndTs = getTimeStampAndHash()
        var queryItems = [
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hashAndTs.hash),
            URLQueryItem(name: "ts", value: hashAndTs.timeStamp),
        ]
        if !param.isEmpty{
            queryItems.append(contentsOf: param.map({URLQueryItem(name: $0, value: "\($1)")}))
        }
        components?.queryItems = queryItems
        guard let url = components?.url else {
            return completion(nil, nil, NSError(domain: "URL Error", code: 0, userInfo: nil))
        }
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.GET.rawValue
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
}
