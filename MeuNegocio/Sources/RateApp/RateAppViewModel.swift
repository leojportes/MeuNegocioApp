//
//  RateAppViewModel.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 19/12/22.
//

protocol RateAppViewModelProtocol {
    func close()
    func goToReview()
}

class RateAppViewModel: RateAppViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: RateAppCoordinator?
    
    // MARK: - Init
    init(coordinator: RateAppCoordinator?) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator?.close()
    }

    func goToReview() {
        coordinator?.goToReview()
    }
}
