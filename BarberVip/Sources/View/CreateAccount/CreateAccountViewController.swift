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
    }
    
    
    override func loadView() {
        super.loadView()
        contentView = CreateAccountView()
        self.view = contentView
    }
    
    private func createAccount() {
        contentView?.createAccount = { [ weak self ] email, password, nameBarber in
            self?.viewModel.createAccount(email, password, nameBarber, resultCreateUser: { result in
                if result {
                    UserDefaults.standard.set(email, forKey: "email")
                    self?.dismiss(animated: true)
                }
            })
        }
        
        contentView?.closedView = { [ weak self] in
            self?.dismiss(animated: true)
        }
        
    }
    
}
