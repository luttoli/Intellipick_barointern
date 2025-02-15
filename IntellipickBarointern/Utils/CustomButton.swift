//
//  CustomButton.swift
//  IntellipickBarointern
//
//  Created by 김지훈 on 2/15/25.
//

import UIKit

import SnapKit

class CustomButton: UIButton {
    // MARK: - Enum
    enum ButtonType {
        case textButton(title: String, color: ButtonColor, size: ButtonSize)
        
        enum ButtonColor {
            case lavender
            case disabled
            case white
            
            var textColor: UIColor {
                switch self {
                case .lavender:
                    return .text.white
                case .disabled:
                    return .text.subDarkGray
                case .white:
                    return .text.lavender
                }
            }
            
            var backgroundColor: UIColor {
                switch self {
                case .lavender:
                    return .button.lavender
                case .disabled:
                    return .button.disabled
                case .white:
                    return .text.white
                }
            }
            
            var borderColor: UIColor? {
                switch self {
                case .white:
                    return .border.lavender
                default:
                    return nil
                }
            }
        }
        
        enum ButtonSize {
            case large
            case half
            case small

            var size: (width: CGFloat, height: CGFloat) {
                switch self {
                case .large:
                    return (Constants.screenWidth - (Constants.margin.horizontal * 2), Constants.size.size45)
                case .half:
                    return ((Constants.screenWidth - (Constants.margin.horizontal * 3)) / 2, Constants.size.size40)
                case .small:
                    return (Constants.size.size65, Constants.size.size35)
                }
            }
            
            var fontSize: CGFloat {
                switch self {
                case .large:
                    return Constants.size.size18
                case .half:
                    return Constants.size.size15
                case .small:
                    return Constants.size.size12
                }
            }
        }
        
        enum IconType {
            case plus
            case minus
            case checkBox
            case heart
            case left
            case right
            
            var image: UIImage? {
                switch self {
                case .plus:
                    return UIImage(systemName: "plus.square.fill")
                case .minus:
                    return UIImage(systemName: "minus.square.fill")
                case .checkBox:
                    return UIImage(systemName: "checkmark.square")
                case .heart:
                    return UIImage(systemName: "heart")
                case .left:
                    return UIImage(systemName: "chevron.left")
                case .right:
                    return UIImage(systemName: "chevron.right")
                }
            }
            
            var selectedImage: UIImage? {
                switch self {
                case .checkBox:
                    return UIImage(systemName: "checkmark.square.fill")
                case .heart:
                    return UIImage(systemName: "heart.fill")
                default:
                    return nil
                }
            }
            
            var isToggleable: Bool {
                // 체크박스와 하트만 토글 가능
                return self == .checkBox || self == .heart
            }
        }
    }
    
    var isChecked: Bool = false
    
    // MARK:  Initializer
    init(type: ButtonType) {
        super.init(frame: .zero)
        setUp(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension CustomButton {
    func setUp(type: ButtonType) {
        clipsToBounds = true
        
        switch type {
        case .textButton(let title, let color, let size):
            setTitle(title, for: .normal)
            setTitleColor(color.textColor, for: .normal)
            titleLabel?.font = UIFont.toPretendard(size: size.fontSize, weight: .medium)
            backgroundColor = color.backgroundColor
            
            let size = size.size
            self.snp.makeConstraints {
                $0.width.equalTo(size.width)
                $0.height.equalTo(size.height)
            }
            
            layer.cornerRadius = Constants.radius.px10
            
            if let borderColor = color.borderColor {
                layer.borderWidth = 1
                layer.borderColor = borderColor.cgColor
            }
        }
    }
}
