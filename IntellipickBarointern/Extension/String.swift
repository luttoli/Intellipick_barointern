//
//  String.swift
//  IntellipickBarointern
//
//  Created by 김지훈 on 2/15/25.
//

import UIKit

extension String {
    //이메일
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.(com|co\\.kr|net)"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    //소문자, 특수문자, 숫자 8자 이상 15자 이하 일 때 -> true
    func isValidPassword() -> Bool {
        let regularExpression = "(?=.*[a-z])(?=.*\\d)(?=.*[$@$!%*?&^])[A-Za-z\\d$@$!%*?&]{8,15}"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }
}
