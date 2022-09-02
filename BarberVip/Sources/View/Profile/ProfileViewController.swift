//
//  ProfileViewController.swift
//  BarberVip
//
//  Created by Renilson Moreira on 23/08/22.
//

import UIKit

class ProfileViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    private let customView = ProfileView()
    private let viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "perfil"
        closedFlow()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    func closedFlow() {
        customView.closed = weakify { $0.viewModel.signOut { [ weak self ] result in
            result ? self?.viewModel.closedView() : self?.showAlert(title: "Ocorreu um erro",
                                                        messsage: "Tente novamente mais tarde")
        } }
    }

}
