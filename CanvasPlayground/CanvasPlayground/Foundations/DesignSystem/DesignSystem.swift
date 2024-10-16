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
    }

    struct Paddings {
        static let defaultPadding: CGFloat = 16
    }
}

extension UIColor {
    static let mainBackground = UIColor(named: "background")!
    static let bgSecondary = UIColor(named: "backgroundSecondary")!
}

extension Color {
    static let mainBackground = Color("background")
}
