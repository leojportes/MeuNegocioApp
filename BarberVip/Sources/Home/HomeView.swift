//
//  HomeView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import UIKit

final class HomeView: UIView, ViewCodeContract {
    
    // MARK: - Actions properties
    var openMonthlyReport: Action?
    var openDailyReport: Action?
    var openAlertAction: Action?
    var openProfile: Action?
    var openAddProcedure: Action?
    var openHelp: Action?
    var openProcedureDetails: (GetProcedureModel) -> Void?
    var didPullRefresh: Action?

    // MARK: - Properties
    var procedures: [GetProcedureModel] = [] {
        didSet {
            tableview.reloadData()
            tableview.loadingIndicatorView(show: false)
        }
    }
    
    // MARK: - Init
    init(
        navigateToMonthlyReport: @escaping Action,
        navigateToDailyReport: @escaping Action,
        alertAction: @escaping Action,
        navigateToProfile: @escaping Action,
        navigateToAddProcedure: @escaping Action,
        navigateToHelp: @escaping Action,
        openProcedureDetails: @escaping (GetProcedureModel) -> Void?,
        didPullRefresh: @escaping Action
    ) {
        self.openMonthlyReport = navigateToMonthlyReport
        self.openDailyReport = navigateToDailyReport
        self.openAlertAction = alertAction
        self.openProfile = navigateToProfile
        self.openAddProcedure = navigateToAddProcedure
        self.openHelp = navigateToHelp
        self.openProcedureDetails = openProcedureDetails
        self.didPullRefresh = didPullRefresh
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sectionCardsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var navBarView: BarberNavBar = {
        let navigation = BarberNavBar(backButtonAction: weakify { $0.openProfile?() },
                                      nameUser: "Olá, Renilson")
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    
    private lazy var mainBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [reportDailyCard, reportMonthlyCard, infoCard])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var reportDailyCard: CardButtonView = {
        let view = CardButtonView(icon: "ic_report-daily", title: "Relatório Diário")
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCardReportDaily(_:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var reportMonthlyCard: CardButtonView = {
        let view = CardButtonView(icon: "ic_report", title: "Relatório Semanal")
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCardReportMonthly(_:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var infoCard: CardButtonView = {
        let view = CardButtonView(icon: "ic_help", title: "Informações")
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCardInfo(_:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lista de serviços"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
  
      
    private lazy var moreButton: IconButton = {
        let button = IconButton()
        button.setup(image: UIImage(named: Icon.more.rawValue),
                     backgroundColor: .clear,
                     action: { [weak self] in
                        self?.openAddProcedure?()
                     })
        return button
    }()
    
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProcedureTableViewCell.self, forCellReuseIdentifier: ProcedureTableViewCell.identifier)
        table.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.identifier)
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        table.separatorStyle = .none
        table.loadingIndicatorView()
        return table
    }()
    
    // MARK: - Actions
    @objc private func pullToRefresh() {
        self.didPullRefresh?()
    }
    
    @objc func didTapCardReportDaily(_ sender: UITapGestureRecognizer) {
        openDailyReport?()
    }
    
    @objc func didTapCardReportMonthly(_ sender: UITapGestureRecognizer) {
        openMonthlyReport?()
    }
    
    @objc func didTapCardInfo(_ sender: UITapGestureRecognizer) {
        openHelp?()
    }

    // MARK: - Viewcode methods
    func setupHierarchy() {
        addSubview(headerView)
        addSubview(sectionCardsView)
        addSubview(mainBaseView)
        
        headerView.addSubview(navBarView)
        
        sectionCardsView.addSubview(cardStackView)
        sectionCardsView.addSubview(titleLabel)
        sectionCardsView.addSubview(moreButton)
        
        mainBaseView.addSubview(tableview)
    }
    
    func setupConstraints() {
        
        /// Header
        headerView
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(58)
        
        navBarView
            .centerY(in: headerView)
            .leftAnchor(in: headerView)
            .rightAnchor(in: headerView)
        
        /// Section Cards
        sectionCardsView
            .topAnchor(in: headerView, attribute: .bottom)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(230)
        
        cardStackView
            .centerY(in: sectionCardsView)
            .leftAnchor(in: sectionCardsView, attribute: .left, padding: 10)
            .rightAnchor(in: sectionCardsView, attribute: .right, padding: 10)
            .heightAnchor(80)
        
        titleLabel
            .leftAnchor(in: sectionCardsView, padding: 11)
            .bottomAnchor(in: sectionCardsView, padding: 11)
        
        moreButton
            .rightAnchor(in: sectionCardsView, padding: 15)
            .bottomAnchor(in: sectionCardsView, padding: 12)
            .heightAnchor(30)
            .widthAnchor(30)
        
        /// Main
        mainBaseView
            .topAnchor(in: sectionCardsView, attribute: .bottom)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useMargins)
        
        tableview
            .topAnchor(in: mainBaseView)
            .leftAnchor(in: mainBaseView, padding: 0)
            .rightAnchor(in: mainBaseView, padding: 0)
            .bottomAnchor(in: mainBaseView, padding: 5)
        
    }
    
    func setupConfiguration() {
        self.backgroundColor = UIColor.BarberColors.lightBrown
        self.sectionCardsView.backgroundColor = UIColor.BarberColors.darkGray
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
}

// MARK: - Extension UITableView Delegate and DataSource
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if procedures.isEmpty{
            return 1
        }
        return procedures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if procedures.isEmpty{
            let cellEmpty = tableview.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath) as? ErrorTableViewCell
            cellEmpty?.isUserInteractionEnabled = false
            return cellEmpty ?? UITableViewCell()
        } else {
            let cell = tableview.dequeueReusableCell(withIdentifier: ProcedureTableViewCell.identifier, for: indexPath) as? ProcedureTableViewCell
            let procedure = procedures[indexPath.row]
            
            cell?.setupCustomCell(
                title: procedure.nameClient,
                procedure: procedure.typeProcedure,
                price: "R$\(procedure.value.replacingOccurrences(of: ".", with: ","))",
                paymentMethod: "\(procedure.currentDate) • \(procedure.formPayment.rawValue)"
            )
            cell?.setPaymentIcon(method: procedure.formPayment)
            return cell ?? UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let procedure = procedures[indexPath.row]
        self.openProcedureDetails(procedure)
    }
}
