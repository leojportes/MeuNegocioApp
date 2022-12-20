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
    case thirtyDays = "Este mês"
    case custom = "Personalizado"
}

final class FilterSegmentedControl: UIView, ViewCodeContract {

    private var didSelectIndexClosure: (ButtonFilterType) -> Void?
    
    var segmentedControlButtons: [UIButton] = []
    
    let all = SegmentedControlButton(title: ButtonFilterType.all.rawValue)
    let today = SegmentedControlButton(title: ButtonFilterType.today.rawValue)
    let sevenDays = SegmentedControlButton(title: ButtonFilterType.sevenDays.rawValue)
    let thirtyDays = SegmentedControlButton(title: ButtonFilterType.thirtyDays.rawValue)
    let custom = SegmentedControlButton(title: ButtonFilterType.custom.rawValue)

    var currentIndexFilter: ButtonFilterType = .all {
        didSet {
            if currentIndexFilter == .all {
                handleSegmentedControlButtons(sender: UIButton())
                all.backgroundColor = .MNColors.lightBrown
            }
        }
    }
    
    // MARK: - Init
    init(didSelectIndexClosure: @escaping (ButtonFilterType) -> Void) {
        self.segmentedControlButtons = [all, today, sevenDays, thirtyDays, custom]
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: segmentedControlButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 30)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    @objc func handleSegmentedControlButtons(sender: UIButton) {
        for button in segmentedControlButtons {
            if button == sender {
                button.backgroundColor = .MNColors.lightBrown
                let title = button.titleLabel?.text ?? .stringEmpty
                self.didSelectIndexClosure(ButtonFilterType(rawValue: title) ?? .all)
            } else {
                button.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
            }
        }
    }

    func setupHierarchy() {
        addSubview(container)
        container.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 30),

            scrollView.topAnchor.constraint(equalTo: container.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 30),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupConfiguration() {
        segmentedControlButtons.forEach {
            $0.addTarget(
                self,
                action: #selector(handleSegmentedControlButtons(sender:)),
                for: .touchUpInside
            )
        }
    }
}

class SegmentedControlButton: UIButton {

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
        self.roundCorners(cornerRadius: 15)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        self.layer.borderColor = UIColor.black.cgColor
    }

}
