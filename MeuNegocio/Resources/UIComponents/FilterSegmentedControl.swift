//
//  FilterSegmentedControl.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 14/10/22.
//

import UIKit

enum ButtonFilterType: String {
    case all = "Todos"
    case today = "Hoje"
    case sevenDays = "7 dias"
    case thirtyDays = "30 dias"
    case custom = "Personalizado"
}

final class FilterSegmentedControl: UIView {
    
    private var items: [String]
    private var didSelectIndexClosure: (ButtonFilterType) -> Void?
    
    var segmentedControlButtons: [UIButton] = []
    
    let all = UIButton().createSegmentedControlButton(setTitle: "Todos")
    let today = UIButton().createSegmentedControlButton(setTitle: "Hoje")
    let sevenDays = UIButton().createSegmentedControlButton(setTitle: "7 dias")
    let thirtyDays = UIButton().createSegmentedControlButton(setTitle: "30 dias")
    let custom = UIButton().createSegmentedControlButton(setTitle: "Personalizado")
    
    var currentIndexFilter: ButtonFilterType = .all {
        didSet {
            if currentIndexFilter == .all {
                handleSegmentedControlButtons(sender: UIButton())
                all.backgroundColor = .white
            }
        }
    }
    
    init(
        items: [String] = ["Todos", "Hoje","7 dias","30 dias", "Personalizado"],
        didSelectIndexClosure: @escaping (ButtonFilterType) -> Void
    ) {
        self.segmentedControlButtons = [all, today, sevenDays, thirtyDays, custom]
        self.items = items
        self.didSelectIndexClosure = didSelectIndexClosure
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var filterRangeLabel = MNLabel(
        text: "Período:",
        font: UIFont.boldSystemFont(ofSize: 15),
        textColor: .MNColors.grayDarkest
    )
    
    lazy var filterRangeValue = MNLabel(
        font: UIFont.boldSystemFont(ofSize: 14),
        textColor: .MNColors.grayDescription
    )
    
    lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    func configureView() {
        addSubview(container)
        container.addSubview(scrollView)
        scrollView.addSubview(stackView)
        segmentedControlButtons.forEach {$0.addTarget(self, action: #selector(handleSegmentedControlButtons(sender:)), for: .touchUpInside)}
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: container.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func handleSegmentedControlButtons(sender: UIButton) {
        for button in segmentedControlButtons {
            if button == sender {
                button.backgroundColor = .white
                let title = button.titleLabel?.text ?? .stringEmpty
                self.didSelectIndexClosure(ButtonFilterType(rawValue: title) ?? .all)
            } else {
                button.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
            }
        }
    }
}

extension UIButton {
    func createSegmentedControlButton(setTitle to: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(to, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 0.5
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }
}
