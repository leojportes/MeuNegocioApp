//
//  MenuCardView.swift
//  MeuNegocio
//
//  Created by Renilson Moreira on 21/10/22.
//

import UIKit


class MenuCardView: UIView {
    
    var closureReport: Action?
    var closureInfoCard: Action?
    var closureMore: Action?
    
    init(closureReport: @escaping Action,
         closureInfoCard: @escaping Action,
         closureMore: @escaping Action) {
        super.init(frame: .zero)
        
        self.closureReport = closureReport
        self.closureInfoCard = closureInfoCard
        self.closureMore = closureMore
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
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
    
    // MARK: - Actions Cards
    @objc func didTapCardReport(_ sender: UITapGestureRecognizer) {
        closureReport?()
    }
    
    @objc func didTapCardInfo(_ sender: UITapGestureRecognizer) {
        closureInfoCard?()
    }
    
    @objc func didTapCardMore(_ sender: UITapGestureRecognizer) {
        closureMore?()
    }
    
}
extension MenuCardView: ViewCodeContract {
    func setupHierarchy() {
        addSubview(container)
        container.addSubview(reportCard)
        container.addSubview(infoCard)
        container.addSubview(moreCard)
    }
    
    func setupConstraints() {
        container
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .heightAnchor(110)
        
        reportCard
            .leftAnchor(in: container)
        
        infoCard
            .centerX(in: container)
        
        moreCard
            .rightAnchor(in: container)
    }
    
    func setupConfiguration() {
        self.heightAnchor(110)
    }
    
}
