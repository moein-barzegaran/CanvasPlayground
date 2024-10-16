//
//  OverlaysListViewModel.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import Foundation
import Combine

final class OverlaysListViewModel: ObservableObject {

    @Published var overlays: [OverlayCategory] = []
    @Published var selectedCategory: OverlayCategory?

    var selectedCategoryItems: [Overlay] {
        selectedCategory?.items ?? []
    }
    
    private let service: OverlaysServiceServicable

    init(
        service: OverlaysServiceServicable = OverlaysService(client: MainHTTPClient())
    ) {
        self.service = service
        getOverlays()
    }

    func setSelectedItem(_ item: Overlay) {
        // TODO: 🔥 Handle selecting item
    }

    func setSelectedOverlayCategory(_ category: OverlayCategory) {
        selectedCategory = category
    }

    // Private methods

    private func getOverlays() {
        Task {
            let result = await service.getOverlays()

            switch result {
            case .success(let overlays):
                DispatchQueue.main.async { [weak self] in
                    self?.overlays = overlays
                }

            case .failure:
                break
            }
        }
    }
}
