//
//  HTTPClient.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

class MainHTTPClient: HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        do {
            let request = try self.buildRequest(from: endpoint)
            do {
                let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
                guard let response = response as? HTTPURLResponse else {
                    return .failure(.noResponse)
                }
                
                switch response.statusCode {
                case 200...299:
                    guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                        return .failure(.decode)
                    }
                    return .success(decodedResponse)
                default:
                    return .failure(.unexpectedStatusCode)
                }
            } catch {
                return .failure(.unknown)
            }
        } catch {
            return .failure(.requestBuild)
        }
    }
    
    fileprivate func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        var request = URLRequest(
            url: endpoint.baseURL.appendingPathComponent("\(endpoint.path)"),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )

        request.timeoutInterval = 60
        request.httpMethod = endpoint.method.rawValue
        return request
    }
}
