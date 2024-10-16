//
//  AspectRatio.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//


import UIKit

extension UIImage {
    enum AspectRatio {
        case horizontal
        case vertical
        case square
        case unknown
    }

    func adaptiveResize(
        limitation: CGSize = DesignSystem.Size.maximumSize
    ) -> CGSize {
        let imageRatio = size.width / size.height
        let aspectRatio = getImageAspectRatio()
        switch aspectRatio {
        case .horizontal, .square:
            guard size.width > limitation.width else { return size }
            return CGSize(
                width: limitation.width,
                height: limitation.width / imageRatio
            )

        case .vertical:
            guard size.height > limitation.height else { return size }
            return CGSize(
                width: limitation.height * imageRatio,
                height: limitation.height
            )

        default:
            return size
        }
    }

    private func getImageAspectRatio() -> AspectRatio {
        let imageRatio = size.width / size.height
        return switch imageRatio {
        case _ where imageRatio < 1 : .vertical
        case _ where imageRatio > 1 : .horizontal
        case 1: .square
        default: .unknown
        }
    }
}
