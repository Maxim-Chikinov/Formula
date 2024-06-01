//
//  APIProvider.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation
import Combine

class APIProvider<Endpoint: EndpointProtocol> {
    func getData(from endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        guard let request = performRequest(for: endpoint) else {
            return Fail(error: APIProviderErrors.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return loadData(with: request)
            .eraseToAnyPublisher()
    }
    
    func getData(from endpoint: Endpoint) async throws -> Data {
        guard let request = performRequest(for: endpoint) else {
            throw APIProviderErrors.invalidURL
        }
        print("\n>>> Request\n", request.cURL(pretty: false))
        let data = try await loadData(with: request)
        return data
    }
    
    // MARK: - Request building
    private func performRequest(for endpoint: Endpoint) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint.absoluteURL) else {
            return nil
        }

        urlComponents.queryItems = endpoint.params.compactMap({ param -> URLQueryItem in
            return URLQueryItem(name: param.key, value: param.value)
        })

        guard let url = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadRevalidatingCacheData,
                                    timeoutInterval: 30)
        
        endpoint.headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
    }
    
    // MARK: - Getting data
    private func loadData(with request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ error -> Error in
                APIErrors(rawValue: error.code.rawValue) ?? APIProviderErrors.unknownError
            })
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    private func loadData(with request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let httpResponse = response as! HTTPURLResponse
        
        print("<<< Response\ncode:", httpResponse.statusCode)
        print("JSON:", data.toJSON != nil ? "has data" : "empty")
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw APIProviderErrors.badStatusCode
        }
        return data
    }
}
