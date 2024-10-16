//
//  OverlayCategory.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

struct OverlayCategory {
    let title: String
    let items: [Overlay]
    let thumbnailUrl: String
}

extension OverlayCategory: Identifiable, Hashable {
    var id: String { title }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
