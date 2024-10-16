//
//  SelectableViewDelegate.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit

protocol SelectableViewDelegate: AnyObject {
    func selectableView(view: SelectableView, isSelected: Bool)
}

class SelectableView: UIView {

    var isSelected = false
    weak var delegate: SelectableViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapHandler(_:))
        )
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
        delegate?.selectableView(view: self, isSelected: isSelected)
    }

    // MARK: Actions

    @objc private func tapHandler(_ gesture: UITapGestureRecognizer) {
        setSelected(!isSelected)
    }
}
