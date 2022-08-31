//
//  CreateAccountViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 15/08/22.
//

import UIKit

class CreateAccountViewController: CoordinatedViewController {
    
    private var contentView: CreateAccountView?
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
        contentView = CreateAccountView()
        self.view = contentView
    }
    
    private func createAccount() {
        contentView?.createAccount = weakify { weakSelf, email, password, nameBarber in
            weakSelf.viewModel.createAccount(email, password, nameBarber, resultCreateUser: { result in
                if result {
                    UserDefaults.standard.set(email, forKey: "email")
                    weakSelf.dismiss(animated: true)
                } else {
                    weakSelf.showAlert(title: "ocorreu um erro", messsage: "tente criar a conta mais tarde")
                }
            })
        }
        contentView?.closedView = weakify { $0.dismiss(animated: true) }
    }
    
}
