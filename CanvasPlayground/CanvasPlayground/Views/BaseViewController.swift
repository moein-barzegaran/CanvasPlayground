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
    var stickers: [BaseImageView] = []

    private lazy var topLeftCornerView = CornerView()
    private lazy var topRightCornerView = CornerView()
    private lazy var bottomLeftCornerView = CornerView()
    private lazy var bottomRightCornerView = CornerView()

    private lazy var borderView: UIView = {
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.borderColor = UIColor.selectedItemBorder.cgColor
        borderView.layer.borderWidth = DesignSystem.Size.borderWidth
        borderView.layer.shadowColor = UIColor.shadow.cgColor
        borderView.layer.shadowOffset = .zero
        borderView.layer.shadowOpacity = 0.4
        borderView.layer.shadowRadius = 5
        borderView.isUserInteractionEnabled = false
        return borderView
    }()

    private(set) lazy var canvas: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()

    private var panGestureRecognizer: UIPanGestureRecognizer?

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

// Set selection views here
extension BaseViewController {

    func deSelectView() {
        for view in [
            borderView,
            topLeftCornerView,
            topRightCornerView,
            bottomLeftCornerView,
            bottomRightCornerView
        ] {
            view.removeFromSuperview()
        }

        self.selectedView?.isSelected = false
        self.selectedView = nil
    }

    private func setSelected(
        view: BaseImageView,
        isSelected: Bool
    ) {
        addSelectionViews(to: view, isSelected: isSelected)
        addPanGestureRecognizerIfNeeded(for: view, isSelected)
        self.selectedView = view

        view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 4,
            options: .curveEaseInOut,
            animations: {
                view.transform = .identity
            })
    }

    private func addSelectionViews(
        to selectedView: UIView,
        isSelected: Bool
    ) {
        // We will check if we added selection views before or not
        if borderView.superview != nil {
            deSelectView()
        }

        if !isSelected { return }

        view.addSubview(borderView)

        for corner in [
            topLeftCornerView,
            topRightCornerView,
            bottomLeftCornerView,
            bottomRightCornerView
        ] {
            corner.translatesAutoresizingMaskIntoConstraints = false
            corner.widthAnchor.constraint(equalToConstant: DesignSystem.Size.corner).isActive = true
            corner.heightAnchor.constraint(equalTo: corner.widthAnchor).isActive = true
            view.addSubview(corner)
        }

        NSLayoutConstraint.activate([
            topLeftCornerView.centerXAnchor.constraint(equalTo: selectedView.leadingAnchor),
            topLeftCornerView.centerYAnchor.constraint(equalTo: selectedView.topAnchor),

            topRightCornerView.centerXAnchor.constraint(equalTo: selectedView.trailingAnchor),
            topRightCornerView.centerYAnchor.constraint(equalTo: selectedView.topAnchor),

            bottomLeftCornerView.centerXAnchor.constraint(equalTo: selectedView.leadingAnchor),
            bottomLeftCornerView.centerYAnchor.constraint(equalTo: selectedView.bottomAnchor),

            bottomRightCornerView.centerXAnchor.constraint(equalTo: selectedView.trailingAnchor),
            bottomRightCornerView.centerYAnchor.constraint(equalTo: selectedView.bottomAnchor),

            borderView.topAnchor.constraint(equalTo: selectedView.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: selectedView.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: selectedView.trailingAnchor),
            borderView.bottomAnchor.constraint(equalTo: selectedView.bottomAnchor),
        ])
    }

    private func addPanGestureRecognizerIfNeeded(
        for view: UIView,
        _ isSelected: Bool
    ) {
        if let panGestureRecognizer,
           let previousView = panGestureRecognizer.view {
            previousView.removeGestureRecognizer(panGestureRecognizer)
            self.panGestureRecognizer = nil
        }

        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(panGestureHandler)
        )
        view.addGestureRecognizer(panGestureRecognizer)
        self.panGestureRecognizer = panGestureRecognizer
    }
}

// We will detect the edge touch of selected view and resizing action here
extension BaseViewController {

    @objc private func panGestureHandler(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            if let itemView = gesture.view {
                let point = gesture.translation(in: self.view)
                itemView.center = CGPoint(
                    x: itemView.center.x + point.x,
                    y: itemView.center.y + point.y
                )
                gesture.setTranslation(CGPoint.zero, in: self.view)

                // TODO: 🔥 To check the snap points here
            }
        case .ended, .cancelled:
            break

        default:
            break
        }
    }

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

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedView else { return }
        if !selectedView.isSelected { return }
        guard let image = selectedView.image else { return }

        if let touch = touches.first{
            let currentTouchPoint = touch.location(in: view)
            let previousTouchPoint = touch.previousLocation(in: view)

            let deltaX = currentTouchPoint.x - previousTouchPoint.x

            let aspectRatio = image.size.width / image.size.height
            let imageFrame = selectedView.frame

            if resizeRect.topTouch && resizeRect.leftTouch {
                selectedView.frame = CGRect(
                    x: imageFrame.minX + deltaX,
                    y: imageFrame.minY + deltaX / aspectRatio,
                    width: imageFrame.width - deltaX,
                    height: imageFrame.height - (deltaX / aspectRatio)
                )
            }

            if resizeRect.topTouch && resizeRect.rightTouch {
                selectedView.frame = CGRect(
                    x: imageFrame.minX,
                    y: imageFrame.minY - deltaX / aspectRatio,
                    width: imageFrame.width + deltaX,
                    height: imageFrame.height + (deltaX / aspectRatio)
                )
            }

            if resizeRect.bottomTouch && resizeRect.leftTouch {
                selectedView.frame = CGRect(
                    x: imageFrame.minX + deltaX,
                    y: imageFrame.minY,
                    width: imageFrame.width - deltaX,
                    height: imageFrame.height - (deltaX / aspectRatio)
                )
            }

            if resizeRect.bottomTouch && resizeRect.rightTouch {
                selectedView.frame = CGRect(
                    x: imageFrame.minX,
                    y: imageFrame.minY,
                    width: imageFrame.width + deltaX,
                    height: imageFrame.height + (deltaX / aspectRatio)
                )
            }

            // TODO: 🔥 To check the snap points here
        }
    }
}

// MARK: - SelectableViewDelegate

extension BaseViewController: SelectableViewDelegate {
    func selectableView(
        view: SelectableView,
        isSelected: Bool
    ) {
        guard let baseImageView = view as? BaseImageView else { return }
        self.setSelected(view: baseImageView, isSelected: isSelected)
    }
}
