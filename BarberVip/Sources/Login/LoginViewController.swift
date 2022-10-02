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
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    // MARK: - Private methods
    private func showError( _ descriptionError: String) {
        self.showAlert(title: "Atenção", messsage: descriptionError)
        self.customView.loginButton.loadingIndicator(show: false)
    }
    
    private func checkNewUser() {
        self.customView.loginButton.loadingIndicator(show: false)
        viewModel.fetchUser { [ weak self ] result in
            DispatchQueue.main.async {
                result.isEmpty ? self?.viewModel.navigateToUserOnboarding() : self?.viewModel.navigateToHome()
            }
        }
    }
}

extension LoginViewController: LoginScreenActionsProtocol {
    func didTapLogin(_ email: String, _ password: String) {
        viewModel.authLogin(email, password) { [weak self] onSuccess, descriptionError in
            onSuccess ? self?.checkNewUser() : self?.showError(descriptionError)
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
            result ? self?.checkNewUser() : self?.showError("Tente novamente")
        }
    }
}



