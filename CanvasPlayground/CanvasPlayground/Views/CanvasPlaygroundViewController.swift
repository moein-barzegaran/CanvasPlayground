//
//  ViewController.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit

class CanvasPlaygroundViewController: UIViewController {

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
        // TODO: 🔥 Add action for plus button here
    }
}

