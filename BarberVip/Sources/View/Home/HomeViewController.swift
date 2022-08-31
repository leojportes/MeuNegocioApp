//
//  HomeViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import UIKit

final class HomeViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var navigateToMonthlyReport: Action?
    var navigateToDailyReport: Action?
    var navigateToProfile: Action?
    var navigateToAddJob: Action?
    
    // MARK: - Private properties
    private let customView = HomeView()
    
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
            monthlyReportAction: weakify { $0.navigateToMonthlyReport?() },
            dailyReportAction: weakify { $0.navigateToDailyReport?() },
            alertAction: weakify { $0.showAlert()},
            navigateToProfile: weakify { $0.navigateToProfile?() },
            navigateToAddJob: weakify { $0.navigateToAddJob?() })
    }
}
