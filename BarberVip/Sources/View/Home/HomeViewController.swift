//
//  HomeViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import UIKit

final class HomeViewController: CoordinatedViewController {
    
    // MARK: - Properties
    private let viewModel: HomeViewModelProtocol

    // MARK: - View
    private lazy var customView = HomeView(
        navigateToMonthlyReport: weakify { $0.viewModel.navigateToMonthlyReport() },
        navigateToDailyReport: weakify { $0.viewModel.navigateToDailyReport()},
        alertAction: weakify { $0.showAlert()},
        navigateToProfile: weakify { $0.viewModel.navigateToProfile() },
        navigateToAddJob: weakify { $0.viewModel.navigateToAddJob() },
        navigateToHelp: weakify { $0.viewModel.navigateToHelp() }
    )

    // MARK: - Init
    init(viewModel: HomeViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
