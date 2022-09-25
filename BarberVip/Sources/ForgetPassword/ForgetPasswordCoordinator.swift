//
//  ForgetPasswordCoordinator.swift
//  BarberVip
//
//  Created by Leonardo Portes on 04/09/22.
//

import UIKit

class ForgetPasswordCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = ForgetPasswordViewModel(coordinator: self)
        let controller = ForgetPasswordViewController(viewModel: viewModel, coordinator: self)
        configuration.viewController = controller
        configuration.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configuration.navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        configuration.navigationController?.present(controller, animated: true)
    }

}
