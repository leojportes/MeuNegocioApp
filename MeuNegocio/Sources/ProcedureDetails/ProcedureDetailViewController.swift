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
    private lazy var customView = ProcedureDetailView(didTapDelete: weakify { $0.deleteProcedure(procedure: $1) }, valuesUpdate: { self.updateProcedure(procedure: $0) })
    
    

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
    
    private func updateProcedure(procedure: GetProcedureModel) {
        self.viewModel.updateProcedure(procedure) { result in
            self.customView.editingContainer.saveButton.loadingIndicator(show: false)
            
            let model = GetProcedureModel(_id: procedure._id,
                                          nameClient: result.nameClient ?? procedure.nameClient,
                                          typeProcedure: result.typeProcedure ?? procedure.typeProcedure,
                                          formPayment: PaymentMethodType(rawValue: result.formPayment ?? "") ?? procedure.formPayment,
                                          value: result.value ?? procedure.value,
                                          currentDate: procedure.currentDate,
                                          email: procedure.email,
                                          costs: result.costs ?? procedure.costs,
                                          valueLiquid: result.valueLiquid ?? procedure.valueLiquid
            )
            
            self.showAlert(title: "", messsage: "Procedimento atualizado!") {
                self.updateLayout(model)
            }
        }
    }

    private func deleteProcedure(procedure: String) {
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
    
    private func updateLayout(_ procedures: GetProcedureModel) {
        self.customView.setupView(procedure: procedures)
        self.customView.updated(true)
    }

}
