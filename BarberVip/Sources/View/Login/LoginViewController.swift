//
//  LoginViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit

class LoginViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var navigateToHome: Action?
    var navigateToRegister: Action?
    var navigateToForgotPassword: Action?
    
    // MARK: - Private properties
    private let customView = LoginView()
    private let viewModel: LoginViewModelProtocol

    init(viewModel: LoginViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegateAction = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.emailTextField.text = UserDefaults.standard.string(forKey: "email")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customView.passwordTextField.text = .stringEmpty
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
}

extension LoginViewController: LoginScreenActionsProtocol {
    func didTapLogin(_ email: String, _ password: String) {
        viewModel.authLogin(email, password) { [ weak self ] authResult in
            if authResult {
                self?.navigateToHome?()
            }else {
                self?.showAlert(title: "houve um erro", messsage: "verifique novamente os campos preenchidos")
            }
        }
    }
    
    func didTapForgotPassword() {
        self.navigateToForgotPassword?()
    }
    
    func didTapRegister() {
        self.navigateToRegister?()
    }
}
