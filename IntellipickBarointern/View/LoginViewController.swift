//
//  LoginViewController.swift
//  IntellipickBarointern
//
//  Created by 김지훈 on 2/15/25.
//

import UIKit

import SnapKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    // 타이틀
    let titleLabel = CustomLabel(title: "IntelliPick", size: Constants.size.size30, weight: .Bold, color: .text.black)
    
    // 이메일 텍스트필드
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "이메일을 입력해주세요."
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderColor = UIColor.border.darkGray.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 8
        return emailTextField
    }()

    // 비밀번호 텍스트필드
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "비밀번호를 입력해주세요."
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor.border.darkGray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.isSecureTextEntry = true
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
extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        
        emailCheck()
        passwordCheck()
        startButtonAction()
        
        // 가입 여부 테스트 확인 용
        print(UserDefaults.standard.string(forKey: "savedEmail") ?? "")
        print(UserDefaults.standard.string(forKey: "savedPassword") ?? "")
    }
}

// MARK: - Navigation
extension LoginViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
    }
}

// MARK: - SetUp
private extension LoginViewController {
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
        
        // 시작하기 버튼 기본값 비활성화 설정
        startButton.isEnabled = false
    }
}

// MARK: - Method
private extension LoginViewController {
    // 이메일 체크
    func emailCheck() {
        emailTextField.addAction(UIAction(handler: { [weak self] _ in
            self?.validateFields()
        }), for: .editingChanged)
    }

    // 비번 체크
    func passwordCheck() {
        passwordTextField.addAction(UIAction(handler: { [weak self] _ in
            self?.validateFields()
        }), for: .editingChanged)
    }

    // 이메일과 비밀번호 정규식 체크 후 버튼 활성화
    func validateFields() {
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        // 이메일 유효성 검사
        let isValidEmail = emailText.isValidEmail()
        
        // 이메일 텍스트필드 테두리색 변경
        if !emailText.isEmpty { // 이메일 입력이 있을 때만 테두리 변경
            emailTextField.layer.borderColor = isValidEmail ? UIColor.border.darkGray.cgColor : UIColor.border.red.cgColor
        }

        // 비밀번호 유효성 검사
        let isValidPassword = passwordText.isValidPassword()
        
        // 비밀번호 텍스트필드 테두리색 변경
        if !passwordText.isEmpty { // 비밀번호 입력이 있을 때만 테두리 변경
            passwordTextField.layer.borderColor = isValidPassword ? UIColor.border.darkGray.cgColor : UIColor.border.red.cgColor
        }

        // 둘 다 유효할 경우 버튼 활성화
        if isValidEmail && isValidPassword {
            startButton.isEnabled = true
            startButton.setTitleColor(.text.white, for: .normal)
            startButton.backgroundColor = .button.lavender
        } else {
            startButton.isEnabled = false
            startButton.setTitleColor(.text.subDarkGray, for: .normal)
            startButton.backgroundColor = .button.disabled
        }
    }
    
    // 로그인 버튼 클릭 -> 아이디, 비밀번호 확인 후 회원가입, 로그인 진행
    //              -> 회원이면 그냥 로그인
    //              -> 비회원이면 회원가입 후 로그인
    func startButtonAction() {
        startButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            
            // 저장된 이메일, 비밀번호 가져오기
            let savedEmail = UserDefaults.standard.string(forKey: "savedEmail")
            let savedPassword = UserDefaults.standard.string(forKey: "savedPassword")
            
            if let savedEmail = savedEmail, let savedPassword = savedPassword {
                // 기존 계정 정보와 일치하는 경우 로그인 처리
                if savedEmail == email && savedPassword == password {
                    showAlert(title: "로그인 성공", message: "환영합니다!") {
                        self.navigateToLoginSuccess()
                    }
                } else {
                    // 아이디 또는 비밀번호 불일치
                    showAlert(title: "로그인 실패", message: "아이디 또는 비밀번호가 올바르지 않습니다.")
                }
            } else {
                // 저장된 계정 정보가 없으면 회원가입 처리
                UserDefaults.standard.set(email, forKey: "savedEmail")
                UserDefaults.standard.set(password, forKey: "savedPassword")
                showAlert(title: "회원가입 완료", message: "회원가입이 완료되었습니다.") {
                    self.navigateToLoginSuccess()
                }
            }
        }), for: .touchUpInside)
    }

    // 얼럿 노출 함수
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        }
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }

    // 로그인 성공 화면으로 이동
    func navigateToLoginSuccess() {
        view.endEditing(true) // 키보드 닫기
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        let loginSuccessVC = LoginSuccessViewController()
        let navigationController = UINavigationController(rootViewController: loginSuccessVC) // 네비게이션 컨트롤러 추가
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
