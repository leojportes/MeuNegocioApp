//
//  ForgetPasswordViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import UIKit

class ForgetPasswordViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    private lazy var customView = ForgetPasswordView(didTapResetAction: weakify { $0.viewModel?.resetPassFirebase(email: $1) })

    private let viewModel: ForgetPasswordViewModelProtocol?
    
    // MARK: - Init
    init(viewModel: ForgetPasswordViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Redefinir senha"
    }

    override func loadView() {
        super.loadView()
        self.view = customView
    }

}
