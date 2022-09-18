//
//  WebClientProtocol.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum WebClientError: Error {
    case invalidRequest, invalidStatusCodeResponse, noDataToDecode, errorDecodingData
}

protocol WebClientProtocol {
    func performRequest<T: Decodable>(request: URLRequest) async throws -> T
}
