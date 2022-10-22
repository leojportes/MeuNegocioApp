//
//  ForgetPasswordCoordinator.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 04/09/22.
//

import UIKit

class ForgetPasswordCoordinator: BaseCoordinator {
    public var email: String = ""

    override func start() {
        let viewModel = ForgetPasswordViewModel(coordinator: self)
        let controller = ForgetPasswordViewController(viewModel: viewModel, coordinator: self, email: email)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.navigationBar.tintColor = .MNColors.darkGray
        configuration.navigationController?.present(controller, animated: true)
    }

}
