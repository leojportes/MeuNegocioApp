//
//  HomeViewController.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 07/02/22.
//

import UIKit

final class HomeViewController: CoordinatedViewController {
    
    // MARK: - Properties
    private let viewModel: HomeViewModelProtocol
    private var procedures: [GetProcedureModel] = []
    private var userData: UserModelList = []

    // MARK: - View
    private lazy var customView = HomeView(
        navigateToReport: weakify { $0.viewModel.navigateToReport(procedures: $0.procedures)},
        alertAction: weakify { $0.showAlert()},
        navigateToProfile: weakify { $0.viewModel.navigateToProfile($0.userData) },
        navigateToAddProcedure: weakify { $0.viewModel.navigateToAddProcedure() },
        navigateToHelp: weakify { $0.viewModel.navigateToHelp() },
        openProcedureDetails: weakify { $0.viewModel.openProcedureDetails($1) },
        didPullRefresh: weakify { $0.didPullToRefresh() },
        didSelectIndexClosure: weakify { $0.didSelectFilter($1) }
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
        bindProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        bindProperties()
        self.customView.currentIndex = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func bindProperties() {
        viewModel.input.viewDidLoad()
        viewModel.output.procedures.bind() { [weak self] result in
            self?.customView.procedures = result.reversed()
            self?.procedures = result.reversed()
            self?.setInitialFilterDateRange(result.reversed())
            self?.customView.totalReceiptCard.setupCardValues(
                totalValues: self?.viewModel.input.makeTotalAmounts(result),
                procedureValue: "\(result.count)")
            self?.customView.totalReceiptCard.loadingIndicatorView(show: false)
        }
        
        viewModel.output.userData.bind { [weak self] result in
            self?.userData = result
            self?.customView.userName = result.first?.name ?? ""
        }
        
        reloadData()
    }
    
    private func setInitialFilterDateRange(_ procedures: [GetProcedureModel]) {
        let dates = procedures.map { $0.currentDate }
        let firstDate = dates.first ?? ""
        let lastDate = dates.last ?? ""
        
        if procedures.count > 1 && firstDate != lastDate {
            self.customView.filterRange = "\(firstDate) - \(lastDate)"
        } else if procedures.count >= 1 {
            self.customView.filterRange = "\(firstDate)"
        }

        self.customView.filterView.filterRangeValue.isHidden = procedures.isEmpty
        self.customView.filterView.filterRangeLabel.isHidden = procedures.isEmpty
    }

    private func didPullToRefresh() {
        bindProperties()
        self.customView.currentIndex = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.customView.tableview.refreshControl?.endRefreshing()
            self.reloadData()
        }
    }

    private func reloadData() {
        self.customView.tableview.reloadData()
    }
    
    private func filteredProcedures(
        procedures: [GetProcedureModel],
        lastDays: Int = 0,
        isMonthly: Bool = false
    ) -> [GetProcedureModel] {
        let lastDaysDates = isMonthly ? Date.getDatesOfCurrentMonth() : Date.getDates(forLastNDays: lastDays)
        self.customView.filterRange = "\(lastDaysDates.last ?? "") - \(lastDaysDates.first ?? "")"
        return procedures.filter({ lastDaysDates.contains($0.currentDate) })
    }

    func todayProcedures(procedures: [GetProcedureModel]) -> [GetProcedureModel] {
        let procedures = procedures.filter({$0.currentDate == returnCurrentDate})
        customView.filterRange = returnCurrentDate
        return procedures
    }

    var returnCurrentDate: String = {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dateString = df.string(from: date)
        return dateString
    }()

    private func didSelectFilter(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            setInitialFilterDateRange(procedures)
            self.customView.procedures = procedures

        case 1: self.customView.procedures = todayProcedures(procedures: procedures)
        case 2: self.customView.procedures = filteredProcedures(procedures: procedures, lastDays: 7)
        case 3: self.customView.procedures = filteredProcedures(procedures: procedures, isMonthly: true)
        default: break
        }
    }
}
