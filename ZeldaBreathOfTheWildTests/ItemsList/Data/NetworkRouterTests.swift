//
//  NetworkRouterTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 18/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

final class NetworkRouterTests: XCTestCase {

    private var sut: NetworkRouter!
    private var categoryAPICategoryMapper: DefaultCategoryAPICategoryMapper!
    
    override func setUp() {
        super.setUp()
        categoryAPICategoryMapper = DefaultCategoryAPICategoryMapper()
        sut = NetworkRouter(categoryAPICategoryMapper: categoryAPICategoryMapper)
    }

    override func tearDown() {
        categoryAPICategoryMapper = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - getEndpoint

extension NetworkRouterTests {
    func test_WHEN_getEndpoint_GIVEN_someCategory_THEN_itShouldReturnTheEndpoint() {
        let endpoint = sut.getEndpoint(for: .materials)
        XCTAssertEqual(endpoint.url, URL(string:"https://botw-compendium.herokuapp.com/api/v2/category/materials"))
        XCTAssertEqual(endpoint.body, nil)
        XCTAssertEqual(endpoint.httpMethod, .GET)
    }
}
