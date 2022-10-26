//
//  ProcedureDetailViewController.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 25/09/22.
//

import Foundation
import UIKit

final class ProcedureDetailViewController: CoordinatedViewController {
    
    // MARK: - Properties
    private let viewModel: ProcedureDetailViewModelProtocol
    private var procedure: GetProcedureModel

    // MARK: - View
    private lazy var customView = ProcedureDetailView(didTapDelete: weakify { $0.didTapDelete(procedure: $1) })

    // MARK: - Init
    init(viewModel: ProcedureDetailViewModelProtocol, coordinator: CoordinatorProtocol, procedure: GetProcedureModel) {
        self.viewModel = viewModel
        self.procedure = procedure
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        tappedOutViewBottomSheetDismiss()
        customView.setupView(procedure: procedure)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIViewController.findCurrentController()?.viewWillAppear(true)
    }

    private func didTapDelete(procedure: String) {
        self.showDeleteAlert(closedScreen: true) {
            self.viewModel.deleteProcedure(procedure) { message in
                DispatchQueue.main.async {
                    self.showAlert(title: "", messsage: message) {
                        self.closedView()
                    }
                }
            }
        }
    }

    private func closedView() {
        self.customView.deleteButton.loadingIndicator(show: false)
        self.dismiss(animated: true)
    }

}
