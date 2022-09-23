//
//  HomeView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 07/02/22.
//

import UIKit

final class HomeView: UIView, ViewCodeContract {
    
    // MARK: - Properties
    var openMonthlyReport: Action?
    var openDailyReport: Action?
    var openAlertAction: Action?
    var openProfile: Action?
    var openAddJob: Action?
    var openHelp: Action?
    
    // MARK: - Init
    init(
        navigateToMonthlyReport: @escaping Action,
        navigateToDailyReport: @escaping Action,
        alertAction: @escaping Action,
        navigateToProfile: @escaping Action,
        navigateToAddJob: @escaping Action,
        navigateToHelp: @escaping Action
    ) {
        self.openMonthlyReport = navigateToMonthlyReport
        self.openDailyReport = navigateToDailyReport
        self.openAlertAction = alertAction
        self.openProfile = navigateToProfile
        self.openAddJob = navigateToAddJob
        self.openHelp = navigateToHelp
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
    
    private(set) lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ServiceBarberTableViewCell.self, forCellReuseIdentifier: ServiceBarberTableViewCell.identifier)
        return table
    }()
    
    private lazy var clientIcon: IconButton = {
        let button = IconButton()
        button.setup(image: UIImage(named: Icon.beard.rawValue),
                     backgroundColor: .clear)
        button.setIcon(height: 25, width: 25)
        return button
    }()
    
    private lazy var procedureIcon: IconButton = {
        let button = IconButton()
        button.setup(image: UIImage(named: Icon.procedure.rawValue),
                     backgroundColor: .clear)
        return button
    }()
    
    private lazy var priceIcon: IconButton = {
        let button = IconButton()
        button.setup(image: UIImage(named: Icon.money.rawValue),
                     backgroundColor: .clear)
        return button
    }()
    
    private lazy var paymentMethodIcon: IconButton = {
        let button = IconButton()
        button.setup(image: UIImage(named: Icon.paymentMethod.rawValue),
                     backgroundColor: .clear)
        return button
    }()
    
    private lazy var horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        footerBaseView.addSubview(clientIcon)
        footerBaseView.addSubview(procedureIcon)
        footerBaseView.addSubview(priceIcon)
        footerBaseView.addSubview(paymentMethodIcon)
        footerBaseView.addSubview(horizontalLine)
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
            .topAnchor(in: footerBaseView, padding: 40)
            .leftAnchor(in: footerBaseView, padding: 5)
            .rightAnchor(in: footerBaseView, padding: 10)
            .bottomAnchor(in: footerBaseView, padding: 5)
        
        clientIcon
            .topAnchor(in: footerBaseView, padding: 10)
            .leftAnchor(in: footerBaseView, padding: 40)
            .widthAnchor(20)
            .heightAnchor(18)
        
        procedureIcon
            .topAnchor(in: footerBaseView, padding: 10)
            .leftAnchor(in: clientIcon, attribute: .right, padding: 65)
            .widthAnchor(20)
            .heightAnchor(18)
        
        priceIcon
            .topAnchor(in: footerBaseView, padding: 10)
            .leftAnchor(in: procedureIcon, attribute: .right, padding: 75)
            .widthAnchor(20)
            .heightAnchor(18)
        
        paymentMethodIcon
            .topAnchor(in: footerBaseView, padding: 10)
            .rightAnchor(in: footerBaseView, padding: 50)
            .widthAnchor(20)
            .heightAnchor(18)
        
        horizontalLine
            .topAnchor(in: clientIcon, attribute: .bottom, padding: 11)
            .leftAnchor(in: footerBaseView)
            .rightAnchor(in: footerBaseView)
            .heightAnchor(1)
        
    }
    
    func setupConfiguration() {
        self.backgroundColor = UIColor.BarberColors.lightBrown
        self.headerView.backgroundColor = UIColor.BarberColors.darkGray
        self.tableview.delegate = self
        self.tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        
        horizontalLine.isHidden = true
    }
    
}

// MARK: - Extension UITableView Delegate and DataSource
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: ServiceBarberTableViewCell.identifier, for: indexPath) as! ServiceBarberTableViewCell
        cell.setupCustomCell(title: "Barbeiro \(indexPath.row + 1)",
                             procedure: "Corte e Barba",
                             price: "R$ 50,00",
                             paymentMethod: "Pix")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let shouldDisplay = scrollView.contentOffset.y >= 15
        horizontalLine.isHidden = shouldDisplay.not
    }
    
}
