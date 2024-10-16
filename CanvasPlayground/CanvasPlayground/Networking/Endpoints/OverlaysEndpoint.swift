//
//  OverlaysEndpoint.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

enum OverlaysEndpoint {
    case getOverlays
}

extension OverlaysEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getOverlays:
            return "/scrl/test/overlays"
        }
    }
    var method: HTTPMethod { .get }
}
