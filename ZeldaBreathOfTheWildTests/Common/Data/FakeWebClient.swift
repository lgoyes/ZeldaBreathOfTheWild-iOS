//
//  FakeWebClient.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 14/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

class FakeWebClient: WebClientProtocol {
    var error: ZeldaBreathOfTheWild.WebClientError?
    var result: Decodable?
    
    func performRequest<T>(request: URLRequest, onSuccess: @escaping (T) -> Void, onError: @escaping (ZeldaBreathOfTheWild.WebClientError) -> Void) where T : Decodable {
        if let error = error {
            onError(error)
        } else if let result = result as? T {
            onSuccess(result)
        }
    }
}
