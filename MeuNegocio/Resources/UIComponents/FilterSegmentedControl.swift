//
//  FilterSegmentedControl.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 14/10/22.
//

import UIKit

final class FilterSegmentedControl: UIView, ViewCodeContract {
    
    private var items: [String]
    private var didSelectIndexClosure: (UISegmentedControl) -> Void?
    
    var currentIndex: Int = 0 {
        didSet {
            segmentedControl.selectedSegmentIndex = self.currentIndex
        }
    }
    
    init(
        items: [String] = ["Todos", "Hoje","7 dias","30 dias", "Personalizado"],
        didSelectIndexClosure: @escaping (UISegmentedControl) -> Void
    ) {
        self.items = items
        self.didSelectIndexClosure = didSelectIndexClosure
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: items)
        seg.selectedSegmentTintColor = .MNColors.lightBrown
        seg.selectedSegmentIndex = 0
        seg.numberOfSegments = 0
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.addTarget(self, action: #selector(didSelectIndex(_:)), for: .valueChanged)
        return seg
    }()
    
    private(set) lazy var filterRangeLabel = MNLabel(
        text: "Período:",
        font: UIFont.boldSystemFont(ofSize: 15),
        textColor: .MNColors.grayDarkest
    )
    
    lazy var filterRangeValue = MNLabel(
        font: UIFont.boldSystemFont(ofSize: 14),
        textColor: .MNColors.grayDescription
    )
    
    @objc
    private func didSelectIndex(_ sender: UISegmentedControl) {
        self.didSelectIndexClosure(sender)
    }

    func setupHierarchy() {
        addSubview(container)
        container.addSubview(segmentedControl)
        container.addSubview(filterRangeLabel)
        container.addSubview(filterRangeValue)
    }
    
    func setupConstraints() {
        container
            .topAnchor(in: self)
            .leftAnchor(in: self)
            .rightAnchor(in: self)
            .bottomAnchor(in: self)
        
        segmentedControl
            .topAnchor(in: container)
            .leftAnchor(in: container)
            .rightAnchor(in: container)
            .heightAnchor(30)
        
        filterRangeLabel
            .topAnchor(in: segmentedControl, attribute: .bottom, padding: 6)
            .leftAnchor(in: container, padding: 4)
            .bottomAnchor(in: container, attribute: .bottom)
        
        filterRangeValue
            .topAnchor(in: segmentedControl, attribute: .bottom, padding: 6)
            .leftAnchor(in: filterRangeLabel, attribute: .right, padding: 6)
            .bottomAnchor(in: container, attribute: .bottom)
    }

}
