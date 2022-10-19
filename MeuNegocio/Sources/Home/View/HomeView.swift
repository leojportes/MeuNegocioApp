//
//  HomeView.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 07/02/22.
//

import UIKit

final class HomeView: UIView, ViewCodeContract {
    
    // MARK: - Actions properties
    var openReport: Action?
    var openAlertAction: Action?
    var openProfile: Action?
    var openAddProcedure: Action?
    var openHelp: Action?
    var openProcedureDetails: (GetProcedureModel) -> Void?
    var didPullRefresh: Action?
    var didSelectIndexClosure: (UISegmentedControl) -> Void?

    // MARK: - Properties
    var procedures: [GetProcedureModel] = [] {
        didSet {
            tableview.reloadData()
            tableview.loadingIndicatorView(show: false)
        }
    }

    var currentIndex: Int = 0 {
        didSet {
            filterView.currentIndex = currentIndex
        }
    }

    var filterRange: String = "" {
        didSet {
            filterRangeValue.text = filterRange
        }
    }
    
    var userName: String = .stringEmpty {
        didSet {
            profileView.setupLayout(nameUser: userName )
        }
    }
    
    // MARK: - Init
    init(
        navigateToReport: @escaping Action,
        alertAction: @escaping Action,
        navigateToProfile: @escaping Action,
        navigateToAddProcedure: @escaping Action,
        navigateToHelp: @escaping Action,
        openProcedureDetails: @escaping (GetProcedureModel) -> Void?,
        didPullRefresh: @escaping Action,
        didSelectIndexClosure: @escaping (UISegmentedControl) -> Void?
    ) {
        self.openReport = navigateToReport
        self.openAlertAction = alertAction
        self.openProfile = navigateToProfile
        self.openAddProcedure = navigateToAddProcedure
        self.openHelp = navigateToHelp
        self.openProcedureDetails = openProcedureDetails
        self.didPullRefresh = didPullRefresh
        self.didSelectIndexClosure = didSelectIndexClosure
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Header
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .BarberColors.lightBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.setupAction(actionButton: weakify { $0.openProfile?()})
        return view
    }()
    
    // MARK: - Section Cards
    private lazy var sectionCardsView: UIView = {
        let view = UIView()
        view.backgroundColor = .BarberColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [reportCard, infoCard, moreCard])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var reportCard: CardButtonView = {
        let view = CardButtonView(icon: Icon.report.rawValue, title: "Relatórios")
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCardReport(_:)))
        view.addGestureRecognizer(tap)
        view.addShadow()
        return view
    }()
    
    lazy var infoCard: CardButtonView = {
        let view = CardButtonView(icon: Icon.help.rawValue, title: "Informações")
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCardInfo(_:)))
        view.addGestureRecognizer(tap)
        view.addShadow()
        return view
    }()
    
    lazy var moreCard: CardButtonView = {
        let view = CardButtonView(icon: Icon.more.rawValue, title: "Adicionar")
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCardMore(_:)))
        view.addGestureRecognizer(tap)
        view.addShadow()
        return view
    }()
    
    // MARK: - Main
    private lazy var mainBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProcedureTableViewCell.self, forCellReuseIdentifier: ProcedureTableViewCell.identifier)
        table.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.identifier)
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.roundCorners(cornerRadius: 10, typeCorners: [.topLeft, .topRight])
        table.loadingIndicatorView()
        return table
    }()

    lazy var totalReceiptCard = TotalReceiptCardView() .. {
        $0.loadingIndicatorView(show: true)
    }

    lazy var filterView = FilterSegmentedControl(
        didSelectIndexClosure: weakify {
            $0.didSelectIndexClosure($1)
        }
    )

    private(set) lazy var filterRangeLabel = BarberLabel(
        text: "Período:",
        font: UIFont.boldSystemFont(ofSize: 15),
        textColor: .BarberColors.grayDarkest
    )
    
    private(set) lazy var filterRangeValue = BarberLabel(
        font: UIFont.boldSystemFont(ofSize: 14),
        textColor: .BarberColors.grayDescription
    )
    
    // MARK: - Actions Cards
    @objc private func pullToRefresh() {
        self.didPullRefresh?()
    }
    
    @objc func didTapCardReport(_ sender: UITapGestureRecognizer) {
        openReport?()
    }
    
    @objc func didTapCardInfo(_ sender: UITapGestureRecognizer) {
        openHelp?()
    }
    
    @objc func didTapCardMore(_ sender: UITapGestureRecognizer) {
        openAddProcedure?()
    }

    // MARK: - Viewcode methods
    func setupHierarchy() {
        addSubview(headerView)
        addSubview(sectionCardsView)
        addSubview(mainBaseView)
        sectionCardsView.addSubview(totalReceiptCard)
        sectionCardsView.addSubview(filterView)
        sectionCardsView.addSubview(filterRangeLabel)
        sectionCardsView.addSubview(filterRangeValue)
        
        headerView.addSubview(profileView)
        sectionCardsView.addSubview(cardStackView)
        mainBaseView.addSubview(tableview)
    }
    
    func setupConstraints() {
        
        /// Header
        headerView
            .topAnchor(in: self, layoutOption: .useMargins)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(80)
        
        profileView
            .topAnchor(in: headerView, attribute: .top, padding: 22)
            .leftAnchor(in: headerView, attribute: .left, padding: 10)
            .heightAnchor(40)
        
        /// Section Cards
        sectionCardsView
            .topAnchor(in: headerView, attribute: .bottom)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(320)
        
        cardStackView
            .topAnchor(in: headerView, attribute: .bottom, padding: 20)
            .leftAnchor(in: sectionCardsView, attribute: .left, padding: 10)
            .rightAnchor(in: sectionCardsView, attribute: .right, padding: 10)
            .heightAnchor(106)
    
        totalReceiptCard
            .topAnchor(in: cardStackView, attribute: .bottom, padding: 25)
            .leftAnchor(in: sectionCardsView, padding: 15)
            .rightAnchor(in: sectionCardsView, padding: 15 )
            .heightAnchor(80)
        
        /// Main
        mainBaseView
            .topAnchor(in: sectionCardsView, attribute: .bottom)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useMargins)
        
        filterView
            .bottomAnchor(in: filterRangeLabel, attribute: .top)
            .heightAnchor(45)
            .leftAnchor(in: sectionCardsView)
            .rightAnchor(in: sectionCardsView)
        
        filterRangeLabel
            .bottomAnchor(in: sectionCardsView)
            .leftAnchor(in: sectionCardsView, padding: 15)
            .heightAnchor(25)

        filterRangeValue
            .bottomAnchor(in: sectionCardsView)
            .leftAnchor(in: filterRangeLabel, attribute: .right, padding: 5)
            .widthAnchor(240)
            .heightAnchor(25)

        tableview
            .topAnchor(in: mainBaseView)
            .leftAnchor(in: mainBaseView)
            .rightAnchor(in: mainBaseView)
            .bottomAnchor(in: mainBaseView, padding: -1, layoutOption: .useMargins)
    }
    
    func setupConfiguration() {
        self.backgroundColor = .BarberColors.lightGray
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
}

// MARK: - Extension UITableView Delegate and DataSource
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if procedures.isEmpty { return 1 }
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
            let amounts = Current.shared.formatterAmounts(amounts: procedures)
            let amount = amounts[indexPath.row]
            
            cell?.setupCustomCell(
                title: procedure.nameClient,
                procedure: procedure.typeProcedure,
                price: amount,
                paymentMethod: "\(procedure.currentDate) • \(procedure.formPayment.rawValue)"
            )
            cell?.setPaymentIcon(method: procedure.formPayment)
            return cell ?? UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let procedure = procedures[indexPath.row]
        self.openProcedureDetails(procedure)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Procedimentos"
    }
}
