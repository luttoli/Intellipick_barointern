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
        
    }
}

// MARK: - Method
private extension LoginSuccessViewController {
    //    func <#name#>() {
    //
    //    }
}

// MARK: - Delegate
extension LoginSuccessViewController {
    
}

