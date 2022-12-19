//
//  FilterSegmentedControl.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 14/10/22.
//

import UIKit

final class FilterSegmentedControl: UIView {
    
    private var items: [String]
    private var didSelectIndexClosure: (String) -> Void?
    
    var segmentedControlButtons: [UIButton] = []
        
    let all = UIButton().createSegmentedControlButton(setTitle: "Todos")
    let today = UIButton().createSegmentedControlButton(setTitle: "Hoje")
    let sevenDays = UIButton().createSegmentedControlButton(setTitle: "7 dias")
    let thirtyDays = UIButton().createSegmentedControlButton(setTitle: "30 dias")
    let custom = UIButton().createSegmentedControlButton(setTitle: "Personalizado")

    
    let segmentedControlBackgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
    
    var currentIndex: Int = 0 {
        didSet {
            segmentedControl.selectedSegmentIndex = self.currentIndex
        }
    }
    
    init(
        items: [String] = ["Todos", "Hoje","7 dias","30 dias", "Personalizado"],
        didSelectIndexClosure: @escaping (String) -> Void
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
    
    private lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: items)
        seg.selectedSegmentTintColor = .MNColors.lightBrown
        seg.selectedSegmentIndex = 0
        seg.translatesAutoresizingMaskIntoConstraints = false
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

    lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.backgroundColor = segmentedControlBackgroundColor
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
                    UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                        button.backgroundColor = .white
                        self.didSelectIndexClosure(button.titleLabel?.text ?? .stringEmpty)
                    }

                } else {
                    UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) { [weak self] in
                        button.backgroundColor = self?.segmentedControlBackgroundColor
                    }
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
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }
}
