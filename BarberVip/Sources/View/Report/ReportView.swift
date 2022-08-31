//
//  ReportView.swift
//  BarberVip
//
//  Created by Leonardo Portes on 17/02/22.
//

import UIKit

final class ReportView: UIView, ViewCodeContract {
    
    // MARK: - Properties
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
    private lazy var navigationBar: BarberNavBar = {
        let navigation = BarberNavBar(backgroundColor: UIColor.BarberColors.darkGray,
                                      backgroundColorButtonLeft: .clear,
                                      iconRight: UIImage(named: Icon.back.rawValue),
                                      heightIcon: 20,
                                      widhtIcon: 20,
                                      backButtonAction: weakify { $0.popAction?() })
        
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    
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
        self.addSubview(navigationBar)
        self.addSubview(baseView)
        
        baseView.addSubview(tableview)
        baseView.addSubview(clientIcon)
        baseView.addSubview(procedureIcon)
        baseView.addSubview(priceIcon)
        baseView.addSubview(paymentMethodIcon)
        baseView.addSubview(horizontalLine)
        baseView.addSubview(bottomHorizontalLine)
        baseView.addSubview(totalLabel)
        
        baseView.addSubview(topScrollView)
        topScrollView.addSubview(scrollToTopButton)
    }
    
    func setupConstraints() {
        navigationBar
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(70)
        
        baseView
            .topAnchor(in: navigationBar, attribute: .bottom)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self, layoutOption: .useMargins)
        
        tableview
            .topAnchor(in: baseView, padding: 40)
            .leftAnchor(in: baseView, padding: 5)
            .rightAnchor(in: baseView, padding: 10)
            .bottomAnchor(in: baseView, padding: 100)
        
        clientIcon
            .topAnchor(in: baseView, padding: 10)
            .leftAnchor(in: baseView, padding: 40)
            .widthAnchor(20)
            .heightAnchor(18)
        
        procedureIcon
            .topAnchor(in: baseView, padding: 10)
            .leftAnchor(in: clientIcon, attribute: .right, padding: 65)
            .widthAnchor(20)
            .heightAnchor(18)
        
        priceIcon
            .topAnchor(in: baseView, padding: 10)
            .leftAnchor(in: procedureIcon, attribute: .right, padding: 75)
            .widthAnchor(20)
            .heightAnchor(18)
        
        paymentMethodIcon
            .topAnchor(in: baseView, padding: 10)
            .rightAnchor(in: baseView, padding: 50)
            .widthAnchor(20)
            .heightAnchor(18)
        
        horizontalLine
            .topAnchor(in: clientIcon, attribute: .bottom, padding: 10)
            .leftAnchor(in: baseView)
            .rightAnchor(in: baseView)
            .heightAnchor(1)
        
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
        navigationBar.set(title: title,
                          color: .white,
                          font: .boldSystemFont(ofSize: 20))
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: ServiceBarberTableViewCell.identifier, for: indexPath) as! ServiceBarberTableViewCell
        cell.setupCustomCell(title: "Barbeiro \(indexPath.row + 1)",
                             procedure: "Corte/Barba",
                             price: "R$ 50,00",
                             paymentMethod: "Pix")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let currentPositionScroll: CGFloat = 170
        
        if position > currentPositionScroll {
            topScrollView.isHidden = false
        } else {
            topScrollView.isHidden = true
        }
    }
    
}
