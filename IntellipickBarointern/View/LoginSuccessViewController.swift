//
//  LoginSuccessViewController.swift
//  IntellipickBarointern
//
//  Created by 김지훈 on 2/15/25.
//

import UIKit

import SnapKit

class LoginSuccessViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    let titleLabel = CustomLabel(title: "", size: Constants.size.size25, weight: .Bold, color: .text.black)
    
    let logoutButton = CustomButton(type: .textButton(title: "로그아웃", color: .white, size: .half))
    let deleteUserButton = CustomButton(type: .textButton(title: "회원탈퇴", color: .disabled, size: .half))

    private lazy var buttonStackView: UIStackView = {
        let buttonStackView = UIStackView(arrangedSubviews: [logoutButton, deleteUserButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = Constants.spacing.px20
        return buttonStackView
    }()

    private lazy var myInfoStackView: UIStackView = {
        let myInfoStackView = UIStackView(arrangedSubviews: [titleLabel, buttonStackView])
        myInfoStackView.axis = .vertical
        myInfoStackView.spacing = Constants.spacing.px20
        return myInfoStackView
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
extension LoginSuccessViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        
        idLabelText()
        logoutButtonAction()
        deleteUserButtonAction()
        
        // 가입 여부 테스트 확인 용
        print(UserDefaults.standard.string(forKey: "savedEmail") ?? "")
        print(UserDefaults.standard.string(forKey: "savedPassword") ?? "")
    }
}


// MARK: - Navigation
extension LoginSuccessViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
    }
}

// MARK: - SetUp
private extension LoginSuccessViewController {
    func setUp() {
        view.addSubview(myInfoStackView)
        
        myInfoStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.numberOfLines = 0
    }
}

// MARK: - Method
private extension LoginSuccessViewController {
    // id 표시
    func idLabelText() {
        let emailText = UserDefaults.standard.string(forKey: "savedEmail") ?? ""
        let idText = emailText.components(separatedBy: "@").first ?? ""
        titleLabel.text = "\(idText)님\n환영합니다.😀"
    }
    
    // 로그아웃 버튼 클릭 동작
    func logoutButtonAction() {
        logoutButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            showAlert(title: "로그아웃 🙇", message: "로그아웃 되었습니다.\n로그인 해주세요.") {
                self.navigateToLogin()
            }
        }), for: .touchUpInside)
    }
    
    // 회원탈퇴 버튼 클릭 동작
    func deleteUserButtonAction() {
        deleteUserButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            UserDefaults.standard.removeObject(forKey: "savedEmail")
            UserDefaults.standard.removeObject(forKey: "savedPassword")
            
            showAlert(title: "회원탈퇴 😢", message: "탈퇴했습니다.\n다시 회원가입, 로그인 해주세요.") {
                self.navigateToLogin()
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
    func navigateToLogin() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC) // 네비게이션 컨트롤러 추가
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
