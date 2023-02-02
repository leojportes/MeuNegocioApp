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
    private lazy var customView = ProcedureDetailView(didTapDelete: weakify { $0.deleteProcedure(procedure: $1) })

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
        customView.editingContainer.delegate = self
        self.hideKeyboardWhenTappedAround()
    }

    override func loadView() {
        super.loadView()
        view = customView
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
        viewModel.closed()
    }
    
    private func updateLayout(_ procedures: GetProcedureModel) {
        self.customView.setupView(procedure: procedures)
        self.customView.updated(true)
    }

}

extension ProcedureDetailViewController: EditProcedureDelegate {
    func alertForTextField(message: String) {
        customView.editingContainer.saveButton.loadingIndicator(show: false)
        showAlert(title: "", messsage: message)
    }
    
    func isSomeEmptyField(message: String) {
        customView.editingContainer.saveButton.loadingIndicator(show: false)
        showAlert(title: "", messsage: message)
    }
    
    func saveProcedure(procedures: GetProcedureModel) {
        self.viewModel.updateProcedure(procedures) { result, isSuccess in
            self.customView.editingContainer.saveButton.loadingIndicator(show: false)
            let model = GetProcedureModel(_id: procedures._id,
                                          nameClient: result.nameClient ?? procedures.nameClient,
                                          typeProcedure: result.typeProcedure ?? procedures.typeProcedure,
                                          formPayment: PaymentMethodType(rawValue: result.formPayment ?? "") ?? procedures.formPayment,
                                          value: result.value ?? procedures.value,
                                          currentDate: procedures.currentDate,
                                          email: procedures.email,
                                          costs: result.costs,
                                          valueLiquid: result.valueLiquid)
            if isSuccess {
                self.showAlert(title: "", messsage: "Procedimento atualizado!") {
                    self.updateLayout(model)
                }
            } else {
                self.showAlert(title: "Ocorreu um erro", messsage: "Tente novamente mais tarde!")
            }
        }
    }
    
    
}
