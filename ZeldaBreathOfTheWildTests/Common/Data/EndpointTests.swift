//
//  EndpointTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 14/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class EndpointTests: XCTestCase {

    private var sut: Endpoint!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - buildRequest

extension EndpointTests {
    func test_WHEN_buildRequest_GIVEN_someEndpointData_THEN_itShouldReturnRequest() {
        let httpMethod = HTTPMethod.DELETE
        let url = URL(string: "www.google.com")!
        let body = Data()
        sut = Endpoint(httpMethod: httpMethod, url: url, body: body)
        
        let actualResult = sut.buildRequest()
        
        XCTAssertEqual(actualResult.url, url)
        XCTAssertEqual(actualResult.httpMethod, httpMethod.rawValue)
        XCTAssertEqual(actualResult.httpBody, body)
    }
}
