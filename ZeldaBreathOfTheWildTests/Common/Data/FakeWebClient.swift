//
//  FakeWebClient.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 14/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

class FakeWebClient: WebClientProtocol {
    enum AnyError: Error {
        case unexpectedError
    }
    
    var error: ZeldaBreathOfTheWild.WebClientError?
    var result: Decodable?
    
    func performRequest<T>(request: URLRequest) async throws -> T where T : Decodable {
        if let result = result as? T {
            return result
        } else if let error = error {
            throw error
        }
        throw AnyError.unexpectedError
    }
}
