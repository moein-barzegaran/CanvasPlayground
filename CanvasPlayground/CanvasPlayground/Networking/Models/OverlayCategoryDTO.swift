//
//  OverlayCategoryDTO.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

struct OverlayCategoryDTO: Decodable {
    let title: String
    let items: [OverlayDTO]
    let thumbnailUrl: String

    enum CodingKeys: String, CodingKey {
        case title
        case items
        case thumbnailUrl = "thumbnail_url"
    }
}

extension OverlayCategoryDTO {
    func toDomain() -> OverlayCategory {
        OverlayCategory(
            title: title,
            items: items.map { $0.toDomain() },
            thumbnailUrl: thumbnailUrl
        )
    }
}
