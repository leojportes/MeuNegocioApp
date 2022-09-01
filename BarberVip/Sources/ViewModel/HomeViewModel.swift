//
//  HomeViewModel.swift
//  BarberVip
//
//  Created by Renilson Moreira on 31/08/22.
//

protocol HomeViewModelProtocol: AnyObject {
    func navigateToMonthlyReport()
    func navigateToDailyReport()
    func navigateToProfile()
    func navigateToAddJob()
}

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    private var coordinator: HomeCoordinator?
    
    // MARK: - Init
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    // MARK: - Routes
    func navigateToMonthlyReport() {
        coordinator?.navigateTo(.MonthlyReport)
    }
    
    func navigateToDailyReport() {
        coordinator?.navigateTo(.ReportDaily)
    }
    
    func navigateToProfile() {
        coordinator?.navigateTo(.Profile)
    }
    
    func navigateToAddJob() {
        coordinator?.navigateTo(.AddJob)
    }
    
    
}
