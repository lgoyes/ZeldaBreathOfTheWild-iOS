//
//  RESTClient.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

class RESTClient: WebClientProtocol {
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder
    init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func performRequest<T: Decodable>(request: URLRequest) async throws -> T {
        do {
            let (data, _) = try await urlSession.data(for: request)
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw WebClientError.invalidRequest
        }
    }
}
