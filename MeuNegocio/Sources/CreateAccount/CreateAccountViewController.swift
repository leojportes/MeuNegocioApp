//
//  CreateAccountViewController.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 15/08/22.
//

import UIKit

class CreateAccountViewController: CoordinatedViewController {
    
    private var customView: CreateAccountView?
    private let viewModel: CreateAccountViewModelProtocol

    init(viewModel: CreateAccountViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccount()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    override func loadView() {
        super.loadView()
        customView = CreateAccountView()
        self.view = customView
    }
    
    private func createAccount() {
        customView?.createAccount = weakify { weakSelf, email, password in
            weakSelf.viewModel.createAccount(email, password, resultCreateUser: { result, descriptionError  in
                weakSelf.customView?.createAccountButton.loadingIndicator(show: false)
                if result {
                    weakSelf.accountCreatedSuccessfully()
                } else {
                    weakSelf.showAlert(title: "Atenção", messsage: descriptionError)
                }
            })
        }
        customView?.closedView = weakify { $0.viewModel.closed()}
    }
    
    private func accountCreatedSuccessfully() {
        showAlert(title: "Parabéns!", messsage: "Conta criada com sucesso.") {
            self.viewModel.closed()
        }
    }

    
}
