//
//  RESTClientTests.swift
//  ZeldaBreathOfTheWildTests
//
//  Created by Luis David Goyes on 13/09/22.
//

import XCTest
@testable import ZeldaBreathOfTheWild

fileprivate struct DummyResponseType: Decodable { }

final class RESTClientTests: XCTestCase {

    private var sut: RESTClient!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        let jsonDecoder = JSONDecoder()
        
        sut = RESTClient(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }

    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.error = nil
        sut = nil
        super.tearDown()
    }

    func test_WHEN_performRequest_GIVEN_someErrorInRequestExecution_THEN_itShouldThrowErrorCaseInvalidRequest() {
        enum AnyError: Swift.Error {
            case anything
        }
        struct ResponseType: Decodable {
            let id: Int
            let value: String
        }
        
        MockURLProtocol.error = AnyError.anything
        
        let expectation = XCTestExpectation()
        let request = URLRequest(url: URL(string: "www.google.com")!)
        
        Task.init(priority: .userInitiated) {
            do {
                let response : DummyResponseType = try await sut.performRequest(request: request)
                XCTFail()
            } catch {
                XCTAssertEqual(error as! WebClientError, .invalidRequest)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_performRequest_GIVEN_noErrorInRequest_someResponseWithStatusCodeOutsideValidRange_THEN_itShouldThrowErrorCaseInvalidRequest() {
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let expectation = XCTestExpectation()
        let request = URLRequest(url: URL(string: "www.google.com")!)
        
        Task.init(priority: .userInitiated) {
            do {
                let response : DummyResponseType = try await sut.performRequest(request: request)
                XCTFail()
            } catch {
                XCTAssertEqual(error as! WebClientError, .invalidRequest)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_performRequest_GIVEN_noErrorInRequest_someResponseWithValidStatusCode_someDataThatCanNotBeDecodedProperly_THEN_itShouldThrowErrorCaseInvalidRequest() {
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let expectation = XCTestExpectation()
        let request = URLRequest(url: URL(string: "www.google.com")!)
        
        Task.init(priority: .userInitiated) {
            do {
                let response : DummyResponseType = try await sut.performRequest(request: request)
                XCTFail()
            } catch {
                XCTAssertEqual(error as! WebClientError, .invalidRequest)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_performRequest_GIVEN_noErrorInRequest_someResponseWithValidStatusCode_someDataThatCanBeDecodedProperly_THEN_itShoudReturnTheDecodedData() {
        
        struct ResponseType: Decodable {
            let id: Int
            let value: String
        }
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonString = """
                {
                    "id": 1,
                    "value": "some-value"
                }
            """
            let data = jsonString.data(using: .utf8)!
            return (response, data)
        }
        
        let expectation = XCTestExpectation()
        let request = URLRequest(url: URL(string: "www.google.com")!)
        
        Task.init(priority: .userInitiated) {
            do {
                let _ : DummyResponseType = try await sut.performRequest(request: request)
                // This is the correct path
            } catch {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
