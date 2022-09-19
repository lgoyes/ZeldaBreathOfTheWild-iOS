//
//  FakeNetworkRouter.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import Foundation
@testable import ZeldaBreathOfTheWild

final class FakeNetworkRouter: NetworkRoutable {
    var httpMethod: HTTPMethod = .GET
    var url: URL!
    var body: Data?
    
    func getEndpoint(for category: ZeldaBreathOfTheWild.Category) -> ZeldaBreathOfTheWild.Endpoint {
        return Endpoint(httpMethod: httpMethod, url: url, body: body)
    }
}
