//
//  OverlayDTO.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

struct OverlayDTO: Decodable {
    let id: Int
    let overlayName: String
    let categoryId: Int
    let sourceUrl: String
    let isPremium: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case overlayName = "overlay_name"
        case categoryId = "category_id"
        case sourceUrl = "source_url"
        case isPremium = "is_premium"
    }
}

extension OverlayDTO {
    func toDomain() -> Overlay {
        Overlay(
            id: id,
            overlayName: overlayName,
            categoryId: categoryId,
            sourceUrl: sourceUrl,
            isPremium: isPremium
        )
    }
}
