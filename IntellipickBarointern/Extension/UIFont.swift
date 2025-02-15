//
//  UIFont.swift
//  IntellipickBarointern
//
//  Created by 김지훈 on 2/15/25.
//

import UIKit

enum fontWeight {
    case light
    case medium
    case Bold
    case ExtraBold
    case SemiBold
    case Regular
}

extension UIFont {
    static func toPretendard(size: CGFloat, weight: fontWeight) -> UIFont {
        return UIFont(name: "PretendardVariable-\(weight)", size: size)!
    }
}
