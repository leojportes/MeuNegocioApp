//
//  FilterSegmentedControl.swift
//  MeuNegocio
//
//  Created by Leonardo Portes on 14/10/22.
//

import UIKit

final class FilterSegmentedControl: UIView {
    
    private var items: [String]
    private var didSelectIndexClosure: (UIButton) -> Void?
    
    var segmentedControlButtons: [UIButton] = []
    
    let items2  = ["All Fruits", "Orange", "Grapes", "Banana",  "Mango", "papaya", "coconut", "django"]
    let allFruits = UIButton().createSegmentedControlButton(setTitle: "All Fruits")
    let orange = UIButton().createSegmentedControlButton(setTitle: "Orange")
    let grapes = UIButton().createSegmentedControlButton(setTitle: "Grapes")
    let banana = UIButton().createSegmentedControlButton(setTitle: "Banana")
    let mango = UIButton().createSegmentedControlButton(setTitle: "Mango")
    let papaya = UIButton().createSegmentedControlButton(setTitle: "Papaya")
    let coconut = UIButton().createSegmentedControlButton(setTitle: "coconut")
    let django = UIButton().createSegmentedControlButton(setTitle: "django")
    
    let segmentedControlBackgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
    
    var currentIndex: Int = 0 {
        didSet {
            segmentedControl.selectedSegmentIndex = self.currentIndex
        }
    }
    
    init(
        items: [String] = ["Todos", "Hoje","7 dias","30 dias"],
        didSelectIndexClosure: @escaping (UIButton) -> Void
    ) {
        self.segmentedControlButtons = [allFruits,orange,banana,mango,papaya,coconut,django,grapes]
        self.items = items
        self.didSelectIndexClosure = didSelectIndexClosure
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private lazy var container: UIView = {
//        let container = UIView()
//        container.translatesAutoresizingMaskIntoConstraints = false
//        return container
//    }()
//
    
    private lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: items2)
        seg.selectedSegmentTintColor = .MNColors.lightBrown
        seg.selectedSegmentIndex = 0
        seg.translatesAutoresizingMaskIntoConstraints = false
//        seg.addTarget(self, action: #selector(didSelectIndex(_:)), for: .valueChanged)
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
        self.didSelectIndexClosure(sender)
            for button in segmentedControlButtons {
                if button == sender {
                    UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromLeft) {
                        button.backgroundColor = .white
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
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }
}
