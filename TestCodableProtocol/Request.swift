//
//  Request.swift
//  TestCodableProtocol
//
//  Created by Allen Savio on 3/27/19.
//  Copyright © 2019 Allen Savio. All rights reserved.
//

import Foundation
import Alamofire

enum Request {
    case getUser
    
    var execute: DataRequest {
        var request: DataRequest
        switch self {
        case .getUser:
            request = Alamofire.request("/hello", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        }
        return request
    }
}

typealias RequestCompletion<T> = (_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: T) -> Void
extension DataRequest {
    func fetchJson<T: Decodable>(completion: @escaping RequestCompletion<T>) {
        self.responseJSON { (response) in
            
            if let json = response.data {
                do {
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = Utils.superContext
                    let user = try decoder.decode(T.self, from: json)
                    try Utils.superContext?.save()
                    completion(response.request, response.response, user)
                    
                } catch {}
            }
        }
    }
}
