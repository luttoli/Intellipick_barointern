//
//  ViewController.swift
//  IntellipickBarointern
//
//  Created by 김지훈 on 2/15/25.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    // 타이틀
    let titleLabel = CustomLabel(title: "IntelliPick", size: Constants.size.size30, weight: .Bold, color: .text.black)
    
    // 이메일 텍스트필드
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "이메일"
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderColor = UIColor.border.darkGray.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 8
        return emailTextField
    }()

    // 비밀번호 텍스트필드
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor.border.darkGray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 8
        return passwordTextField
    }()
    
    // 시작하기 버튼
    let startButton = CustomButton(type: .textButton(title: "시작하기", color: .disabled, size: .large))
    
    // 로그인에 필요한 세가지 합친 스택뷰
    private lazy var loginStackView: UIStackView = {
        let loginStackView = UIStackView(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, startButton])
        loginStackView.axis = .vertical
        loginStackView.spacing = Constants.spacing.px20
        return loginStackView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        setUp()
    }
}

// MARK: - SetUp
private extension ViewController {
    func setUp() {
        view.addSubview(loginStackView)
        
        loginStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.9)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(Constants.size.size45)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(Constants.size.size45)
        }
    }
}

// MARK: - Method
private extension ViewController {

}

// MARK: - Delegate
extension ViewController {
    
}

