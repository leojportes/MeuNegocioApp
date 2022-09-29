//
//  ReportViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation
import UIKit

final class MonthlyReportViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var popAction: Action?
    
    // MARK: - Private properties
    private let customView = ReportView(
        didTapDiscountSwitch: { _ in },
        didTapDownloadDailyHistoric: { print("didTapDownloadDailyHistoric") },
        didTapDownloadWeeklyHistoric: { print("didTapDownloadWeeklyHistoric") }
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Relatório mensal"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        navigationController?.navigationBar.barTintColor = .white
        setupCustomView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView

    }
    
    // MARK: - Private methods
    private func setupCustomView() {
    }
}
