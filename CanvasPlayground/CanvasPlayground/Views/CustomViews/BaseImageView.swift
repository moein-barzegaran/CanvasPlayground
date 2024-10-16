//
//  BaseImageView.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit
import SDWebImage

class BaseImageView: SelectableView {

    private lazy var imageView = UIImageView()
    private let url: URL

    var image: UIImage? {
        imageView.image
    }

    init?(url: String) {
        guard let url = URL(string: url) else { return nil }
        self.url = url

        super.init(frame: .zero)

        setupViews()
        loadImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Private methods

    private func setupViews() {
        contentMode = .scaleAspectFit
    }

    private func loadImage() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        imageView.sd_setImage(with: url) { [weak self] image, _, _, _ in
            guard let self, let image else { return }

            let adaptiveSize = image.adaptiveResize()

            self.frame = .init(
                x: 0,
                y: 0,
                width: adaptiveSize.width,
                height: adaptiveSize.height
            )
        }
    }
}
