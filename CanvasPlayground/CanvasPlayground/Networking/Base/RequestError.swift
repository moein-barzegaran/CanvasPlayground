//
//  RequestError.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


enum RequestError: Error {
    case decode
    case encode
    case invalidURL
    case noResponse
    case requestBuild
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        default:
            return "Unknown error"
        }
    }
}
