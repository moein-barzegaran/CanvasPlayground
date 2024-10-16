//
//  BaseViewController.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit

class BaseViewController: UIViewController {
    private(set) lazy var canvas: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // Private methods

    private func setupViews() {
        view.addSubview(canvas)

        NSLayoutConstraint.activate([
            canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            canvas.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            canvas.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
        ])
    }
}
