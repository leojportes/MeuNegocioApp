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
        navigateToReport: weakify { $0.viewModel.navigateToReport()},
        alertAction: weakify { $0.showAlert()},
        navigateToProfile: weakify { $0.viewModel.navigateToProfile() },
        navigateToAddProcedure: weakify { $0.viewModel.navigateToAddProcedure() },
        navigateToHelp: weakify { $0.viewModel.navigateToHelp() },
        openProcedureDetails: weakify { $0.viewModel.openProcedureDetails($1) },
        didPullRefresh: weakify { $0.didPullToRefresh() }
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func bindProperties() {
        viewModel.input.viewDidLoad()
        viewModel.output.procedures.bind() { [weak self] result in
            self?.customView.procedures = result.reversed()
        }
        
        viewModel.output.nameUser.bind { [weak self] result in
            guard let name = result.first?.name else { return }
            self?.customView.userName = name
        }
        
        reloadData()
    }

    private func didPullToRefresh() {
        bindProperties()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.customView.tableview.refreshControl?.endRefreshing()
            self.reloadData()
        }
    }

    private func reloadData() {
        self.customView.tableview.reloadData()
    }

}
