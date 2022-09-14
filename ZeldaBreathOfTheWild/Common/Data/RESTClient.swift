//
//  RESTClient.swift
//  ZeldaBreathOfTheWild
//
//  Created by Luis David Goyes on 13/09/22.
//

import Foundation

class RESTClient {
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder
    init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    private func process<T: Decodable>(taskResponse: (data: Data?, response: URLResponse?, error: Error?), onSuccess: @escaping (T) -> Void, onError: @escaping (WebClientError) -> Void) {
        
        guard taskResponse.error == nil else {
            onError(.invalidRequest)
            return
        }
        
        guard let responseData = taskResponse.response as? HTTPURLResponse, (200..<300).contains(responseData.statusCode) else {
            onError(.invalidStatusCodeResponse)
            return
        }
        
        guard let responseToDecode = taskResponse.data else {
            onError(.noDataToDecode)
            return
        }
        
        do {
            let decodedData = try jsonDecoder.decode(T.self, from: responseToDecode)
            onSuccess(decodedData)
        } catch let error {
            print(error.localizedDescription)
            onError(.errorDecodingData)
        }
    }
}

extension RESTClient: WebClientProtocol {
    func performRequest<T: Decodable>(request: URLRequest, onSuccess: @escaping (T) -> Void, onError: @escaping (WebClientError) -> Void) {
        let task = urlSession.dataTask(with: request as URLRequest) { [weak self] (data, respose, error) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.process(taskResponse: (data: data, response: respose, error: error), onSuccess: onSuccess, onError: onError)
            }
        }
        task.resume()
    }
}
