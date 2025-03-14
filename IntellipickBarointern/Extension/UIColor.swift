//
//  UIColor.swift
//  IntellipickBarointern
//
//  Created by 김지훈 on 2/15/25.
//

import UIKit

extension UIColor {
    static let text = TextColor()
    static let textField = TextFieldColor()
    static let button = ButtonColor()
    static let border = BorderColor()
    static let background = BackGroundColor()

    struct TextColor {
        var lavender = UIColor(red: 162/255, green: 149/255, blue: 243/255, alpha: 1.0)
        var black = UIColor.black
        var subDarkGray = UIColor.darkGray
        var white = UIColor.white
        
        var button = ButtonTextColor()
        var notification = NotificationColor()

        struct ButtonTextColor {
            var black = UIColor.black
            var white = UIColor.white
            var disabled = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        }

        struct NotificationColor {
            var red = UIColor.red
        }
    }
    
    struct TextFieldColor {
        var lightGray = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        var darkGray = UIColor.darkGray
    }
    
    struct ButtonColor {
        var white = UIColor.white
        var lavender = UIColor(red: 162/255, green: 149/255, blue: 243/255, alpha: 1.0)
        var lightGray = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        var disabled = UIColor.systemGray4
    }
    
    struct BorderColor {
        var lavender = UIColor(red: 162/255, green: 149/255, blue: 243/255, alpha: 1.0)
        var darkGray = UIColor.darkGray
        var red = UIColor.red
    }
    
    struct BackGroundColor {
        var white = UIColor.white
        var lavender = UIColor(red: 162/255, green: 149/255, blue: 243/255, alpha: 1.0)
        var gray = UIColor.gray
    }
}
