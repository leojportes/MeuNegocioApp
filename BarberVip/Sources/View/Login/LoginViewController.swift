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
    var navigateToCreateAccount: Action?
    var navigateToForgotPassword: Action?
    
    // MARK: - Private properties
    private let customView = LoginView()
    private let viewModel: LoginViewModelProtocol

    init(viewModel: LoginViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
//    static func instantiate(viewModel: LoginViewModelProtocol = LoginViewModelProtocol()) -> LoginViewController {
//        let controller = LoginViewController
//        controller.viewModel = viewModel
//        return controller
//    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        requestLogin("renilson.moreira@gmail.com", "12345672")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    // MARK: - Private methods
    private func setupView() {
        customView.setupHomeView(
            navigateToHome: { [weak self] email, passwords in
                
                self?.viewModel.requestLogin(email ?? "", passwords ?? "", resultLogin: { auth in
                    if auth {
                        self?.navigateToHome?()
                    }
                })
            },
            
            navigateToForgotPassword: { [weak self] in
                self?.navigateToForgotPassword?()},
            
            navigateToCreateAccount: { [weak self] in
                self?.navigateToCreateAccount?()
            })
    }
}
