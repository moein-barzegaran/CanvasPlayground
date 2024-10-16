//
//  Overlay.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import Foundation

struct Overlay {
    let id: Int
    let overlayName: String
    let categoryId: Int
    let sourceUrl: String
    let isPremium: Bool
}

extension Overlay: Identifiable, Hashable {
    var identifier: Int { id }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
