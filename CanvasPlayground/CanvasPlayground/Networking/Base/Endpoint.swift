//
//  HTTPMethod.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var baseURL: URL {
        let urlStr = "https://appostropheanalytics.herokuapp.com"
        guard let url = URL(string: urlStr) else {
            fatalError("Not a valid URL")
        }
        return url
    }
}
