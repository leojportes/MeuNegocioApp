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
        items: [String] = ["Todos", "Hoje","7 dias","30 dias"],
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
    
    private lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: items)
        seg.selectedSegmentTintColor = .BarberColors.lightBrown
        seg.selectedSegmentIndex = 0
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.addTarget(self, action: #selector(didSelectIndex(_:)), for: .valueChanged)
        return seg
    }()
    
    @objc
    private func didSelectIndex(_ sender: UISegmentedControl) {
        self.didSelectIndexClosure(sender)
    }

    func setupHierarchy() {
        addSubview(segmentedControl)
    }
    
    func setupConstraints() {
        segmentedControl
            .heightAnchor(30)
            .centerY(in: self)
            .leftAnchor(in: self, padding: 15)
            .rightAnchor(in: self, padding: 15)
    }

}
