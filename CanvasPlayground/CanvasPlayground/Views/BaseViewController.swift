//
//  BaseViewController.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit

class BaseViewController: UIViewController {

    var resizeRect = ResizeRect()
    var selectedView: BaseImageView?

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

// We will detect the edge touch of selected view and resizing action here
extension BaseViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedView else { return }
        if !selectedView.isSelected { return }

        let selectedViewRect = selectedView.frame

        if let touch = touches.first{

            let touchStart = touch.location(in: canvas)
            let cornerCircleTouchPointSize = DesignSystem.Size.corner

            resizeRect.topTouch = false
            resizeRect.leftTouch = false
            resizeRect.rightTouch = false
            resizeRect.bottomTouch = false

            if touchStart.y > selectedViewRect.maxY - cornerCircleTouchPointSize &&
                touchStart.y < selectedViewRect.maxY + cornerCircleTouchPointSize {
                resizeRect.bottomTouch = true
            }

            if touchStart.x > selectedViewRect.maxX - cornerCircleTouchPointSize &&
                touchStart.x < selectedViewRect.maxX + cornerCircleTouchPointSize {
                resizeRect.rightTouch = true
            }

            if touchStart.x > selectedViewRect.minX - cornerCircleTouchPointSize &&
                touchStart.x < selectedViewRect.minX + cornerCircleTouchPointSize {
                resizeRect.leftTouch = true
            }

            if touchStart.y > selectedViewRect.minY - cornerCircleTouchPointSize &&
                touchStart.y < selectedViewRect.minY + cornerCircleTouchPointSize {
                resizeRect.topTouch = true
            }
        }
    }
}
