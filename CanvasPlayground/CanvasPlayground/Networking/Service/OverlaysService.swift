//
//  OverlaysServiceServicable.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

protocol OverlaysServiceServicable {
    func getOverlays() async -> Result<[OverlayCategory], RequestError>
}

struct OverlaysService: OverlaysServiceServicable {

    private var client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getOverlays() async -> Result<[OverlayCategory], RequestError> {
        let overlaysResult = await client.sendRequest(
            endpoint: OverlaysEndpoint.getOverlays,
            responseModel: [OverlayCategoryDTO].self
        )

        switch overlaysResult {
        case let .success(overlaysCategoriesDTO):
            return .success(overlaysCategoriesDTO.map { $0.toDomain() })

        case let .failure(error):
            return .failure(error)
        }
    }
}
