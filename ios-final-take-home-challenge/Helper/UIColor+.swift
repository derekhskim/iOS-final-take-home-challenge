//
//  UIColor+.swift
//  ios-final-take-home-challenge
//
//  Created by Derek Kim on 2023-04-15.
//

import UIKit

enum DKColor: String {
    case DarkGray
    case DarkGreen
    case LightGray
    case VerySubtleGray
}

extension UIColor {
    static func appColor(_ name: DKColor) -> UIColor! {
        return UIColor(named: name.rawValue)
    }
}
