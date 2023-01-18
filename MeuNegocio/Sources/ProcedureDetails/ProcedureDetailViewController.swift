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
        title = "Detalhes"
        customView.setupView(procedure: procedure)
        self.hideKeyboardWhenTappedAround()
    }

    override func loadView() {
        super.loadView()
        view = customView
    }

    private func didTapDelete(procedure: String) {
        self.showDeleteAlert(closedScreen: true) {
            self.viewModel.deleteProcedure(procedure) { message in
                DispatchQueue.main.async {
                    self.showAlert(title: "", messsage: message) {
                        TrackEvent.track(event: .homeDeleteProcedure)
                        return self.closedView()
                    }
                }
            }
        }
    }

    private func closedView() {
        self.customView.deleteButton.loadingIndicator(show: false)
        self.modalTransitionStyle = .crossDissolve
        self.navigationController?.popViewController(animated: false)
    }

}
