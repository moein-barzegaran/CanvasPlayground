//
//  CornerView.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit

class CornerView: UIView {

    private lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = self.layer as? CAShapeLayer
        return shapeLayer ?? CAShapeLayer()
    }()

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        shapeLayer.fillColor = UIColor.white.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowOpacity = 0.3
        shapeLayer.shadowRadius = 5
    }
}
