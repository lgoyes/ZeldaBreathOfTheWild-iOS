//
//  Endpoint.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

struct Endpoint {
    let httpMethod: HTTPMethod
    let url: URL
    let body: Data?
    
    func buildRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        return request
    }
}
