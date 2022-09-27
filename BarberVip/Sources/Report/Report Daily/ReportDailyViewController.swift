//
//  ReportDailyViewController.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import Foundation
import UIKit

final class ReportDailyViewController: CoordinatedViewController {
    
    // MARK: - Properties
    var popAction: Action?
    
    // MARK: - Private properties
    private let customView = ReportView()
    private let viewModel: ReportDailyViewModelProtocol
    
    // MARK: - Init
    init(viewModel: ReportDailyViewModelProtocol, coordinator: CoordinatorProtocol){
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Relatório diário"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .BarberColors.darkGray
        navigationController?.navigationBar.barTintColor = .white
        setupCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getProcedureList { [ weak self ] result in
            DispatchQueue.main.async {
                /// a ideia é passar a data atual que vem no medoto returnCurrentDate(), mas dado que a api está zoada,
                /// estou passando uma data fixa pra filtrar os procedimentos
                let dailyProcedures = result.filter({$0.currentDate == "26/09/2022"})
                self?.customView.procedures = dailyProcedures
                self?.customView.tableview.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    // MARK: - Private methods
    private func setupCustomView() {
        customView.setupHomeView(title: "Relatório diário",
                                 popAction: weakify { $0.popAction?() })
    }
    
    private func returnCurrentDate() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dateString = df.string(from: date)
        return dateString
    }
}
