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
    var openAddJob: Action?
    var openHelp: Action?
    var deleteProcedure: (String) -> Void?
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
        navigateToAddJob: @escaping Action,
        navigateToHelp: @escaping Action,
        deleteProcedure: @escaping (String) -> Void?,
        didPullRefresh: @escaping Action
    ) {
        self.openMonthlyReport = navigateToMonthlyReport
        self.openDailyReport = navigateToDailyReport
        self.openAlertAction = alertAction
        self.openProfile = navigateToProfile
        self.openAddJob = navigateToAddJob
        self.openHelp = navigateToHelp
        self.deleteProcedure = deleteProcedure
        self.didPullRefresh = didPullRefresh
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Viewcode
    private lazy var navigationBar: BarberNavBar = {
        let navigation = BarberNavBar(iconLeft: UIImage(named: Icon.profile.rawValue),
                                      heightIcon: 20,
                                      widhtIcon: 20,
                                      backButtonAction: weakify { $0.openProfile?() })
        navigation.set(title: "Olá, Leonardo",
                       color: .black,
                       font: .boldSystemFont(ofSize: 20))
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var footerBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var barbersButton: IconButton = {
        let button = IconButton()
        button.roundCorners(cornerRadius: 35, all: true)
        button.backgroundColor = UIColor.BarberColors.lightBrown
        button.setup(image: UIImage(named: Icon.beard.rawValue),
                     backgroundColor: UIColor.BarberColors.lightBrown,
                     action: weakify { $0.openAlertAction?() })
        return button
    }()
    
    private lazy var dailyReportButton: IconButton = {
        let button = IconButton()
        button.roundCorners(cornerRadius: 35, all: true)
        button.backgroundColor = UIColor.BarberColors.lightBrown
        button.setup(image: UIImage(named: Icon.report.rawValue),
                     backgroundColor: UIColor.BarberColors.lightBrown,
                     action: weakify { $0.openDailyReport?() })
        return button
    }()
    
    private lazy var monthlyReportButton: IconButton = {
        let button = IconButton()
        button.roundCorners(cornerRadius: 35, all: true)
        button.backgroundColor = UIColor.BarberColors.lightBrown
        button.setup(image: UIImage(named: Icon.report.rawValue),
                     backgroundColor: UIColor.BarberColors.lightBrown,
                     action: weakify { $0.openMonthlyReport?() })
        return button
    }()
    
    private lazy var helpButton: IconButton = {
        let button = IconButton()
        button.roundCorners(cornerRadius: 35, all: true)
        button.backgroundColor = UIColor.BarberColors.lightBrown
        button.setup(image: UIImage(named: Icon.help.rawValue),
                     backgroundColor: UIColor.BarberColors.lightBrown,
                     action: weakify { $0.openHelp?() })
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lista de serviços"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var barberLabel: UILabel = {
        let label = UILabel()
        label.text = "Profissionais"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var monthlyReportLabel: UILabel = {
        let label = UILabel()
        label.text = "Relatório mensal"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var dailyReportLabel: UILabel = {
        let label = UILabel()
        label.text = "Relatório diário"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Ajuda"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var moreButton: IconButton = {
        let button = IconButton()
        button.setup(image: UIImage(named: Icon.more.rawValue),
                     backgroundColor: .clear,
                     action: { [weak self] in
                        self?.openAddJob?()
                     })
        return button
    }()
    
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProcedureTableViewCell.self, forCellReuseIdentifier: ProcedureTableViewCell.identifier)
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        table.separatorStyle = .none
        table.loadingIndicatorView()
        return table
    }()

    // MARK: - Viewcode methods
    func setupHierarchy() {
        self.addSubview(navigationBar)
        self.addSubview(headerView)
        self.addSubview(footerBaseView)
        headerView.addSubview(barbersButton)
        headerView.addSubview(dailyReportButton)
        headerView.addSubview(monthlyReportButton)
        headerView.addSubview(helpButton)
        headerView.addSubview(titleLabel)
        headerView.addSubview(moreButton)
        
        headerView.addSubview(barberLabel)
        headerView.addSubview(monthlyReportLabel)
        headerView.addSubview(dailyReportLabel)
        headerView.addSubview(infoLabel)
        
        footerBaseView.addSubview(tableview)
    }
    
    func setupConstraints() {
        navigationBar
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: headerView, attribute: .top)
        
        headerView
            .topAnchor(in: self, padding: 66)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(230)
        
        barberLabel
            .topAnchor(in: barbersButton, attribute: .bottom, padding: 10)
            .centerX(in: barbersButton)
        
        monthlyReportLabel
            .topAnchor(in: monthlyReportButton, attribute: .bottom, padding: 10)
            .centerX(in: monthlyReportButton)
            .widthAnchor(60)
        
        dailyReportLabel
            .topAnchor(in: dailyReportButton, attribute: .bottom, padding: 10)
            .centerX(in: dailyReportButton)
            .widthAnchor(60)
        
        infoLabel
            .topAnchor(in: helpButton, attribute: .bottom, padding: 10)
            .centerX(in: helpButton)
            .widthAnchor(60)
        
        footerBaseView
            .topAnchor(in: headerView, attribute: .bottom)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useMargins)
        
        barbersButton
            .topAnchor(in: headerView, padding: 52)
            .leftAnchor(in: headerView, padding: 15)
            .heightAnchor(70)
            .widthAnchor(70)
        
        dailyReportButton
            .topAnchor(in: headerView, padding: 52)
            .leftAnchor(in: barbersButton, attribute: .right, padding: 22)
            .heightAnchor(70)
            .widthAnchor(70)
        
        monthlyReportButton
            .topAnchor(in: headerView, padding: 52)
            .leftAnchor(in: dailyReportButton, attribute: .right, padding: 22)
            .heightAnchor(70)
            .widthAnchor(70)
        
        helpButton
            .topAnchor(in: headerView, padding: 52)
            .leftAnchor(in: monthlyReportButton, attribute: .right, padding: 22)
            .heightAnchor(70)
            .widthAnchor(70)
        
        titleLabel
            .leftAnchor(in: headerView, padding: 11)
            .bottomAnchor(in: headerView, padding: 11)
        
        moreButton
            .rightAnchor(in: headerView, padding: 15)
            .bottomAnchor(in: headerView, padding: 12)
            .heightAnchor(30)
            .widthAnchor(30)
        
        tableview
            .topAnchor(in: footerBaseView)
            .leftAnchor(in: footerBaseView, padding: 0)
            .rightAnchor(in: footerBaseView, padding: 0)
            .bottomAnchor(in: footerBaseView, padding: 5)
        
    }
    
    func setupConfiguration() {
        self.backgroundColor = UIColor.BarberColors.lightBrown
        self.headerView.backgroundColor = UIColor.BarberColors.darkGray
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    @objc private func pullToRefresh() {
        self.didPullRefresh?()
    }
    
}

// MARK: - Extension UITableView Delegate and DataSource
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return procedures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: ProcedureTableViewCell.identifier, for: indexPath) as? ProcedureTableViewCell else {
            return UITableViewCell()
        }
        
        let procedure = procedures[indexPath.row]
        
        cell.setupCustomCell(
            title: procedure.nameClient,
            procedure: procedure.typeProcedure,
            price: "R$\(procedure.value.replacingOccurrences(of: ".", with: ","))",
            paymentMethod: "\(procedure.currentDate) • \(procedure.formPayment.rawValue)"
        )
        cell.setPaymentIcon(method: procedure.formPayment)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let procedure = procedures[indexPath.row]
        self.deleteProcedure(procedure._id)
    }
}
