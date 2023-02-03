//
//  LoginViewController.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 02/08/22.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class LoginViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    fileprivate var currentNonce: String?
    private let customView = LoginView()
    private let viewModel: LoginViewModelProtocol
    var email = ""
    
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
        customView.didEditingTextField = weakify { $0.email = $1}
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.loginButton.loadingIndicator(show: false)
        dismissKeyboard()
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
        /// em caso de email não verificado é removida as credenciais para auto login
        /// e direciona o usuario para tela de verificação de conta.
        if Current.shared.isEmailVerified.not {
            DispatchQueue.main.async {
                KeychainService.deleteCredentials()
                self.viewModel.navigateToCheckYourAccount()
            }
            return
        }
        self.customView.loginButton.loadingIndicator(show: false)
        viewModel.fetchUser { [ weak self ] result in
            DispatchQueue.main.async {
                if result.isEmpty {
                    self?.viewModel.navigateToUserOnboarding()
                } else {
                    self?.viewModel.navigateToHome()
                    guard let email = Auth.auth().currentUser?.email else { return }
                    MNUserDefaults.set(value: true, forKey: email)
                }
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
        viewModel.navigateToForgotPassword(email: self.email)
    }
    
    func didTapRegister() {
        viewModel.navigateToRegister()
    }
    
    func didTapSignInGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func didTapSignInApple() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - Login com o google
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

// MARK: Login com a Apple
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            if let firstName = appleIDCredential.fullName?.givenName {
                MNUserDefaults.set(value: firstName, forKey: MNKeys.nameAppleID)
            }

            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            viewModel.authLoginApple(credentials: credential) { [weak self] result in
                result ? self?.checkNewUser() : self?.showError("Tente novamente")
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = view.window else { return UIWindow() }
        return window
    }
}

extension LoginViewController {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}


