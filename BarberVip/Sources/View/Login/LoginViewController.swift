//
//  LoginViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginViewController: CoordinatedViewController {
    
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
        viewModel.authLogin(email, password) { [weak self] authResult, descriptionError in
            if authResult {
                self?.viewModel.navigateToHome()
                self?.customView.loginButton.loadingIndicator(show: false)
            } else {
                self?.showAlert(title: "Atenção", messsage: descriptionError)
                self?.customView.loginButton.loadingIndicator(show: false)
            }
        }
    }
    
    func didTapForgotPassword() {
        viewModel.navigateToForgotPassword()
    }
    
    func didTapRegister() {
        viewModel.navigateToRegister()
    }
    
    func didTapSignInGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }
        
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        viewModel.authLoginGoogle(credentials: credentials) { [ weak self ] result in
            result ? self?.viewModel.navigateToHome() : self?.showAlert(title: "Houve um erro", messsage: "verifique novamente os campos preenchidos.")
        }
    }
}



