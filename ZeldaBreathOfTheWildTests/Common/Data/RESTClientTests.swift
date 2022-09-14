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

    var sut: RESTClient!
    
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

    func test_WHEN_performRequest_GIVEN_someErrorInRequestExecution_THEN_itShouldInvokeOnErrorClosureWithErrorCaseInvalidRequest() {
        enum AnyError: Swift.Error {
            case anything
        }
        struct ResponseType: Decodable {
            let id: Int
            let value: String
        }
        
        MockURLProtocol.error = AnyError.anything
        
        let successExpectation = XCTestExpectation()
        let failureExpectation = XCTestExpectation()
        failureExpectation.isInverted = true
        let request = URLRequest(url: URL(string: "www.google.com")!)
        sut.performRequest(request: request) { (response: DummyResponseType) in
            failureExpectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, .invalidRequest)
            successExpectation.fulfill()
        }
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func test_WHEN_performRequest_GIVEN_noErrorInRequest_someResponseWithStatusCodeOutsideValidRange_THEN_itShouldInvokeOnErrorClosureWithErrorCaseInvalidStatusCodeResponse() {
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let successExpectation = XCTestExpectation()
        let failureExpectation = XCTestExpectation()
        failureExpectation.isInverted = true
        let request = URLRequest(url: URL(string: "www.google.com")!)
        sut.performRequest(request: request) { (response: DummyResponseType) in
            failureExpectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, .invalidStatusCodeResponse)
            successExpectation.fulfill()
        }
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func test_WHEN_performRequest_GIVEN_noErrorInRequest_someResponseWithValidStatusCode_someDataThatCanNotBeDecodedProperly_THEN_itShouldInvokeOnErrorClosureWithErrorCaseErrorDecodingData() {
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        let successExpectation = XCTestExpectation()
        let failureExpectation = XCTestExpectation()
        failureExpectation.isInverted = true
        let request = URLRequest(url: URL(string: "www.google.com")!)
        sut.performRequest(request: request) { (response: DummyResponseType) in
            failureExpectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, .errorDecodingData)
            successExpectation.fulfill()
        }
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func test_WHEN_performRequest_GIVEN_noErrorInRequest_someResponseWithValidStatusCode_someDataThatCanBeDecodedProperly_THEN_itShouldInvokeOnSuccessClosureTheDecodedData() {
        
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
        
        let successExpectation = XCTestExpectation()
        let failureExpectation = XCTestExpectation()
        failureExpectation.isInverted = true
        let request = URLRequest(url: URL(string: "www.google.com")!)
        sut.performRequest(request: request) { (response: ResponseType) in
            successExpectation.fulfill()
        } onError: { error in
            failureExpectation.fulfill()
        }
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
}
