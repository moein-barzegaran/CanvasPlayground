//
//  DesignSystem.swift
//  CanvasPlayground
//
//  Created by Moein Barzegaran on 10/16/24.
//

import UIKit
import SwiftUI

struct DesignSystem {
    struct Size {
        static let plusButtonSize: CGFloat = 45
        static let closeButtonSize: CGFloat = 30

        static let maxWidthRatio: CGFloat = 0.7
        static let maxHeightRatio: CGFloat = 0.3
        static let maximumSize: CGSize = CGSize(
            width: UIScreen.main.bounds.width * maxWidthRatio,
            height: UIScreen.main.bounds.height * maxHeightRatio
        )

        static let snapLineWidth: CGFloat = 2
        static let borderWidth: CGFloat = 2
        static let corner: CGFloat = 10
    }

    struct Paddings {
        static let defaultPadding: CGFloat = 16
    }
}

extension UIColor {
    static let mainBackground = UIColor(named: "background")!
    static let bgSecondary = UIColor(named: "backgroundSecondary")!
    static let selectedItemBorder = UIColor.white
    static let shadow = UIColor.black
    static let snapLine = UIColor.green
}

extension Color {
    static let mainBackground = Color("background")
    static let bgSecondary = Color("backgroundSecondary")
}
