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

    // MARK: - Private properties
    private let customView = HomeView()
        
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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Private methods
    private func setupView() {
        customView.setupHomeView(
            monthlyReportAction: weakify { $0.viewModel.navigateToMonthlyReport() },
            dailyReportAction: weakify { $0.viewModel.navigateToDailyReport()},
            alertAction: weakify { $0.showAlert()},
            navigateToProfile: weakify { $0.viewModel.navigateToProfile() },
            navigateToAddJob: weakify { $0.viewModel.navigateToAddJob() })
    }
}
