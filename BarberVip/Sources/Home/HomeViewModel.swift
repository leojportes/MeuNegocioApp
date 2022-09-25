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
    func navigateToMonthlyReport()
    func navigateToDailyReport()
    func navigateToProfile()
    func navigateToAddJob()
    func navigateToHelp()
    func deleteProcedure(_ procedure: String, completion: @escaping () -> Void)
}

// MARK: - Protocols
protocol HomeViewModelOutputProtocol {
    var procedures: Bindable<[GetProcedureModel]> { get }
}

protocol HomeViewModelInputProtocol {
    func viewDidLoad()
}

class HomeViewModel: HomeViewModelProtocol, HomeViewModelOutputProtocol {

    private let service: HomeServiceProtocol

    var input: HomeViewModelInputProtocol { self }
    var output: HomeViewModelOutputProtocol { self }
    var procedures: Bindable<[GetProcedureModel]> = .init([])

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

    internal func deleteProcedure(_ procedure: String, completion: @escaping () -> Void) {
        service.deleteProcedure(procedure) {
            completion()
        }
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

    func navigateToHelp() {
        coordinator?.navigateTo(.Help)
    }

}

extension HomeViewModel: HomeViewModelInputProtocol {
    func viewDidLoad() {
        fetchProcedureItems()
    }
}

protocol HomeServiceProtocol {
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void)
    func deleteProcedure(_ procedure: String, completion: @escaping () -> Void)
}

class HomeService: HomeServiceProtocol {

    // Get procedure list
    func getProcedureList(completion: @escaping ([GetProcedureModel]) -> Void) {
        let urlString = "http://54.86.122.10:3000/procedure"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([GetProcedureModel].self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            catch {
                let error = error
                print(error)
            }
        }.resume()
    }

    // Delete procedure
    func deleteProcedure(_ procedure: String, completion: @escaping () -> Void) {
        guard let url = URL(string: "http://54.86.122.10:3000/procedure/\(procedure)") else {
            print("Error: cannot create URL")
            return
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlReq) { _, _, _ in
            completion()
        }.resume()
    }
}
