//
//  ViewController.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit
import SwiftUI

class CanvasPlaygroundViewController: BaseViewController {

    private lazy var plusButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "plus")
        configuration.contentInsets = .zero
        configuration.cornerStyle = .capsule

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(plusButtonTapped),
            for: .touchUpInside
        )
        button.tintColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground

        setupViews()
    }

    private func setupViews() {
        view.addSubview(plusButton)

        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: DesignSystem.Size.plusButtonSize),
            plusButton.widthAnchor.constraint(equalToConstant: DesignSystem.Size.plusButtonSize),
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -DesignSystem.Paddings.defaultPadding)
        ])
    }

    // MARK: Actions

    @objc private func plusButtonTapped() {
        let selectOverlayAction: (Overlay) -> Void = { [weak self] overlay in
            guard let self else { return }
            if let imageView = BaseImageView(
                url: overlay.sourceUrl
            ) {
                canvas.addSubview(imageView)
                imageView.delegate = self
                stickers.append(imageView)
            }
        }

        let viewModel = OverlaysListViewModel(
            selectOverlayAction: selectOverlayAction
        )

        let vc = UIHostingController(rootView: OverlaysListView(viewModel: viewModel))

        viewModel.dismissAction = { [weak vc] in
            vc?.dismiss(animated: true)
        }

        present(vc, animated: true)
    }
}

