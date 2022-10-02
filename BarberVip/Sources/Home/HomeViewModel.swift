//
//  HomeViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 31/08/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var input: HomeViewModelInputProtocol { get }
    var output: HomeViewModelOutputProtocol { get }
    func navigateToReport()
    func navigateToProfile()
    func navigateToAddProcedure()
    func navigateToHelp()
    func openProcedureDetails(_ procedure: GetProcedureModel)
}

// MARK: - Protocols
protocol HomeViewModelOutputProtocol {
    var procedures: Bindable<[GetProcedureModel]> { get }
    var nameUser: Bindable<UserModelList> { get }
}

protocol HomeViewModelInputProtocol {
    func viewDidLoad()
}

class HomeViewModel: HomeViewModelProtocol, HomeViewModelOutputProtocol {

    private let service: HomeServiceProtocol

    var input: HomeViewModelInputProtocol { self }
    var output: HomeViewModelOutputProtocol { self }
    var procedures: Bindable<[GetProcedureModel]> = .init([])
    var nameUser: Bindable<UserModelList> = .init([])

    // MARK: - Properties
    private var coordinator: HomeCoordinator?

    // MARK: - Init
    init(service: HomeServiceProtocol = HomeService(), coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
        self.service = service
    }

    private func fetchProcedureItems() {
        service.getProcedureList { result in
            DispatchQueue.main.async {
                self.procedures.value = result
            }
        }
    }
    
    private func fetchUser() {
        service.fetchUser { result in
            DispatchQueue.main.async {
                self.nameUser.value = result
            }
        }
    }

    // MARK: - Routes
    func navigateToReport() {
        coordinator?.navigateTo(.Report)
    }

    func navigateToProfile() {
        coordinator?.navigateTo(.Profile)
    }

    func navigateToAddProcedure() {
        coordinator?.navigateTo(.AddProcedure)
    }

    func navigateToHelp() {
        coordinator?.navigateTo(.Help)
    }

    func openProcedureDetails(_ procedure: GetProcedureModel) {
        coordinator?.navigateTo(.detailProcedure(procedure))
    }

}

extension HomeViewModel: HomeViewModelInputProtocol {
    func viewDidLoad() {
        fetchProcedureItems()
        fetchUser()
    }
}

