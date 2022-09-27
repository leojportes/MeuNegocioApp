//
//  ReportView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import UIKit

final class ReportView: UIView, ViewCodeContract {
    
    // MARK: - Properties
    var procedures: [GetProcedureModel] = [] {
        didSet {
            tableview.reloadData()
            tableview.loadingIndicatorView(show: false)
        }
    }
    var popAction: Action?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        topScrollView.isHidden = true
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
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.loadingIndicatorView()
        table.register(ProcedureTableViewCell.self, forCellReuseIdentifier: ProcedureTableViewCell.identifier)
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
    
    private lazy var bottomHorizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.BarberColors.darkGray
        label.text = "Total: R$ 2.235,00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.roundCorners(cornerRadius: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topScrollView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollToTopButton: ScrollToTopButton = {
        let button = ScrollToTopButton(image: UIImage(named: Icon.arrowUp.rawValue),
                                colorButton: .black,
                                action: weakify { $0.scrollToTop() })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Viewcode methods
    func setupHierarchy() {
        self.addSubview(baseView)
        baseView.addSubview(tableview)
        baseView.addSubview(bottomHorizontalLine)
        baseView.addSubview(totalLabel)
        
        baseView.addSubview(topScrollView)
        topScrollView.addSubview(scrollToTopButton)
    }
    
    func setupConstraints() {
        baseView
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useMargins)
        
        tableview
            .topAnchor(in: baseView)
            .leftAnchor(in: baseView, padding: 5)
            .rightAnchor(in: baseView, padding: 10)
            .bottomAnchor(in: baseView, padding: 100)

        bottomHorizontalLine
            .bottomAnchor(in: baseView, padding: 100)
            .leftAnchor(in: baseView)
            .rightAnchor(in: baseView)
            .heightAnchor(1)
        
        totalLabel
            .topAnchor(in: bottomHorizontalLine, padding: 15)
            .leftAnchor(in: baseView, padding: 10)
            .rightAnchor(in: baseView, padding: 10)
            .heightAnchor(60)
        
        topScrollView
            .bottomAnchor(in: baseView, padding: 120)
            .rightAnchor(in: baseView, padding: 10)
            .widthAnchor(60)
            .heightAnchor(60)
        
        scrollToTopButton
            .centerY(in: topScrollView)
            .centerX(in: topScrollView)
            .widthAnchor(30)
            .heightAnchor(30)
        
    }
    
    func setupConfiguration() {
        self.backgroundColor = UIColor.BarberColors.lightBrown
        self.headerView.backgroundColor = UIColor.BarberColors.darkGray
        self.tableview.delegate = self
        self.tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        topScrollView.roundCorners(cornerRadius: 30)
    }
    
    // MARK: - Methods
    func setupHomeView(title: String = "",
                       popAction: @escaping Action) {
        self.popAction = popAction
    }
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        self.tableview.scrollToRow(at: topRow,
                                   at: .top,
                                   animated: true)
        
    }
    
}

// MARK: - Extension UITableView Delegate and DataSource
extension ReportView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return procedures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: ProcedureTableViewCell.identifier, for: indexPath) as? ProcedureTableViewCell else { return UITableViewCell()}
        
        let procedure = procedures[indexPath.row]
        
        cell.setupCustomCell(title: procedure.nameClient,
                              procedure: procedure.typeProcedure,
                              price: "R$\(procedure.value.replacingOccurrences(of: ".", with: ","))",
                              paymentMethod: "\(procedure.currentDate) • \(procedure.formPayment.rawValue)")
        
        
        cell.setPaymentIcon(method: procedure.formPayment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let shouldDisplay = scrollView.contentOffset.y >= 15
        horizontalLine.isHidden = shouldDisplay.not
    }
    
}
