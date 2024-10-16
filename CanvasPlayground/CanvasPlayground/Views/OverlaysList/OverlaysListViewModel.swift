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

    var dismissAction: (() -> Void)?

    private let service: OverlaysServiceServicable
    private let selectOverlayAction: (Overlay) -> Void

    init(
        selectOverlayAction: @escaping (Overlay) -> Void,
        service: OverlaysServiceServicable = OverlaysService(client: MainHTTPClient())
    ) {
        self.selectOverlayAction = selectOverlayAction
        self.service = service
        getOverlays()
    }

    func setSelectedItem(_ item: Overlay) {
        selectOverlayAction(item)
        dismissAction?()
    }

    func setSelectedOverlayCategory(_ category: OverlayCategory) {
        selectedCategory = category
    }

    func dismissButtonTapped() {
        dismissAction?()
    }

    // Private methods

    private func getOverlays() {
        Task {
            let result = await service.getOverlays()

            switch result {
            case .success(let overlays):
                DispatchQueue.main.async { [weak self] in
                    self?.overlays = overlays
                    self?.selectedCategory = overlays.first
                }

            case .failure:
                break
            }
        }
    }
}
